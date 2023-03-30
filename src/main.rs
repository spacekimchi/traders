use traders::configuration::get_configuration;
use traders::telemetry::{get_subscriber, init_subscriber};
use dotenv::dotenv;
use traders::startup::Application;

#[actix_web::main]
async fn main() -> anyhow::Result<()> {
    let subscriber = get_subscriber("traders".into(), "info".into(), std::io::stdout);
    init_subscriber(subscriber);

    /* a way for application to ignore errors from loading .env instead of failing */
    dotenv().ok();
    
    let configuration = get_configuration().expect("Failed to read configuration");
    let application = Application::build(configuration).await?;

    application.run_until_stopped().await?;
    Ok(())
}
