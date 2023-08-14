use sqlx::{PgConnection, Executor, Connection};
use traders::configuration::{get_configuration, DatabaseSettings};
use traders::telemetry::{get_subscriber, init_subscriber};
use sqlx::{postgres::PgPoolOptions, Pool, Postgres};
use once_cell::sync::Lazy;
use traders::startup::Application;
use uuid::Uuid;
use argon2::password_hash::SaltString;
use argon2::{Algorithm, Argon2, Params, PasswordHasher, Version};
use fake::faker::internet::en::SafeEmail;
use fake::Fake;

static TRACING: Lazy<()> = Lazy::new(|| {
    let default_filter_level = "info".to_string();
    let subscriber_name = "test".to_string();
    if std::env::var("TEST_LOG").is_ok() {
        let subscriber = get_subscriber(subscriber_name, default_filter_level, std::io::stdout);
        init_subscriber(subscriber);
    } else {
        let subscriber = get_subscriber(subscriber_name, default_filter_level, std::io::sink);
        init_subscriber(subscriber);
    };
});

pub struct TestUser {
    pub user_id: Uuid,
    pub email: String,
    pub username: String,
    pub password: String
}

impl TestUser {
    pub fn generate() -> Self {
        Self {
            user_id: Uuid::new_v4(),
            email: SafeEmail().fake::<String>(),
            username: Uuid::new_v4().to_string(),
            password: Uuid::new_v4().to_string()
        }
    }

    async fn store(&self, pool: &Pool<Postgres>) {
        let email = SafeEmail().fake::<String>();
        let salt = SaltString::generate(&mut rand::thread_rng());
        let password_hash = Argon2::new(
            Algorithm::Argon2id,
            Version::V0x13,
            Params::new(15000, 2, 1, None).unwrap(),
        )
        .hash_password(self.password.as_bytes(), &salt)
        .unwrap()
        .to_string();

        sqlx::query!(
            "INSERT INTO users (id, email, username, password_hash)
            VALUES ($1, $2, $3, $4)",
            self.user_id,
            email,
            self.username,
            password_hash,
        )
        .execute(pool)
        .await
        .expect("Failed to store test user.");
    }
}

pub struct TestApp {
    pub address: String,
    pub port: u16,
    pub db_pool: Pool<Postgres>,
    pub test_user: TestUser,
    pub api_client: reqwest::Client,
}

impl Drop for TestApp {
    fn drop(&mut self) {
        // Shutdown application
        // For example, if your application has a shutdown method, call it here
        // self.application.shutdown();

        // Close the database pool (if required)
        self.db_pool.close();
    }
}

impl TestApp {
    pub async fn post_login<Body>(&self, body: &Body) -> reqwest::Response
    where
        Body: serde::Serialize
    {
        self.api_client
            .post(&format!("{}/api/login", &self.address))
            .form(&body)
            .send()
            .await
            .expect("Failed to execute request.")
    }

    pub async fn post_users(&self, body: &serde_json::Value) -> reqwest::Response {
        self.api_client
            .post(&format!("{}/api/users", &self.address))
            .json(&body)
            .send()
            .await
            .expect("Failed to execute request.")
    }

    pub async fn get_login_html(&self) -> String {
        self.api_client
            .get(&format!("{}/api/login", &self.address))
            .send()
            .await
            .expect("Failed to execute request.")
            .text()
            .await
            .unwrap()
    }

    pub async fn test_user(&self) -> (String, String) {
        let row = sqlx::query!("SELECT username, password_hash FROM users limit 1",)
            .fetch_one(&self.db_pool)
            .await
            .expect("failed to find test users.");
        (row.username, row.password_hash)
    }
}

pub async fn spawn_app() -> TestApp {
    /*
     * The first time 'initialize is invoked the code in 'TRACING' is executed.
     * All other invocations will instead skip execution (so init_subscriber() is only called once)
     */
    Lazy::force(&TRACING);
    let configuration = {
        let mut c = get_configuration().expect("Failed to read configuration");
        // Use a different database for each test case
        c.database.database_name = Uuid::new_v4().to_string();
        // Use a random OS port
        c.application.port = 0;
        c
    };

    let application = Application::build(configuration.clone())
        .await
        .expect("Failed to build application");

    let application_port = application.port();
    let address = format!("http://127.0.0.1:{}", application_port);

    /* Session */
    let db_pool = configure_database(&configuration.database).await;
    
    //let db_pool = match check_database_exists(&configuration.database) {
        //true => configure_database(&configuration.database).await,
        //false => 
    //};

    //let database_exists = check_database_exists(&configuration.database).await;

    //if !database_exists {
        //configure_database(&configuration.database).await;
    //}

    let _ = actix_web::rt::spawn(application.run_until_stopped());
    let client = reqwest::Client::builder()
        .redirect(reqwest::redirect::Policy::none())
        .cookie_store(true)
        .build()
        .unwrap();
    let test_app = TestApp {
        address,
        db_pool,
        port: application_port,
        test_user: TestUser::generate(),
        api_client: client,
    };
    test_app.test_user.store(&test_app.db_pool).await;
    test_app
}

async fn ensure_or_configure_database(config: &DatabaseSettings) -> Pool<Postgres> {
    let mut connection = PgConnection::connect_with(&config.without_db())
        .await
        .expect("Failed to connect to Postgres");

    match check_database_exists(config, &mut connection).await {
        true => {
            // The database exists. Connect to it.
            let connection_pool = PgPoolOptions::new()
                .max_connections(5)
                .connect_with(config.with_db())
                .await
                .expect("Error building a connection pool");
            connection_pool
        }
        false => {
            // The database doesn't exist. Configure a new one.
            configure_database(config).await
        }
    }
}

async fn check_database_exists(config: &DatabaseSettings, connection: &mut PgConnection) -> bool {
    // Connect to the default database to check if your test database exists
    let result: (i64,) = sqlx::query_as("SELECT COUNT(datname) FROM pg_database WHERE datname = $1")
        .bind(&config.database_name)
        .fetch_one(connection)
        .await
        .unwrap();

    result.0 > 0
}

async fn configure_database(config: &DatabaseSettings) -> Pool<Postgres> {
    /* Create database to use for testing */
    println!("\n\n\nDATABASE_NAME: {:?}\n\n\n", config.database_name);
    let mut connection = PgConnection::connect_with(&config.without_db())
        .await
        .expect("Failed to connect to Postgres");
    connection
        .execute(format!(r#"CREATE DATABASE "{}";"#, config.database_name).as_str())
        .await
        .expect("Failed to create database.");

    let connection_pool = PgPoolOptions::new()
        .max_connections(5)
        .connect_with(config.with_db())
        .await
        .expect("Error building a conneciton pool");
    sqlx::migrate!("./migrations")
        .run(&connection_pool)
        .await
        .expect("failed to migrate the database");

    connection_pool
}

async fn add_test_user(pool: &Pool<Postgres>) {
    sqlx::query!(
        "INSERT INTO users (id, username, password_hash)
        VALUES ($1, $2, $3)",
        Uuid::new_v4(),
        Uuid::new_v4().to_string(),
        Uuid::new_v4().to_string(),
    )
    .execute(pool)
    .await
    .expect("Failed to create test users.");
}

pub fn assert_is_redirect_to(response: &reqwest::Response, location: &str) {
    assert_eq!(response.status().as_u16(), 303);
    assert_eq!(response.headers().get("Location").unwrap(), location);
}
