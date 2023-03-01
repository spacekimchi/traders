//! src/configuration.rs

pub fn get_configuration() -> Result<Settings, config::ConfigError> {
    /* Initialise our configuration reader */
    //let mut settings = config::Config::default();

    /*
     * Add configuration values from a file named 'configuration'.
     * It will look for any top-level file with an extension
     * that 'config' knows how to parse: yaml, json, etc.
     */
    let settings = config::Config::builder().add_source(config::File::with_name("configuration"));
    println!("configuration:get_configuration");
    //settings.add_source(config::File::with_name("configuration"))?;

    /*
     * Try to convert the configuration values to read into
     * our Settings type
     */
    //settings.build()
    //settings.try_into()

    //settings.build().try_into()
    match settings.build() {
        Ok(config) => config.try_deserialize::<Settings>(),
        Err(e) => Err(e), 
    }
}

#[derive(serde::Deserialize)]
pub struct Settings {
    pub database: DatabaseSettings,
    pub application_port: u16
}

#[derive(serde::Deserialize)]
pub struct DatabaseSettings {
    pub username: String,
    pub password: String,
    pub port: u16,
    pub host: String,
    pub database_name: String,
}
