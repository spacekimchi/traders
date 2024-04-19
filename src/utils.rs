use chrono::{DateTime, Utc, NaiveDate};
use pulldown_cmark::{html, Parser};

pub mod faq_anchors {
    pub const GOOGLE_IMAGE_TO_MARKDOWN: &str = "google-image-to-markdown";
}

// Return an opaque 500 while preserving the error's root cause for logging.
pub fn e500<T>(e: T) -> actix_web::Error 
where
    T: std::fmt::Debug + std::fmt::Display + 'static
{
    println!("XXXXXXXX ERROR FROM E500: {:?}", e);
    actix_web::error::ErrorInternalServerError(e)
}

pub fn error_chain_fmt(
    e: &impl std::error::Error,
    f: &mut std::fmt::Formatter<'_>,
) -> std::fmt::Result {
    writeln!(f, "{:?}\n", e)?;
    let mut current = e.source();
    while let Some(cause) = current {
        writeln!(f, "Caused by:\n\t{}", cause)?;
        current = cause.source();
    }
    Ok(())
}

/// This function is for returning a string from the currency to have trailing zeros
/// The round(precision=2) in tera templates do not add trailing zeroes
pub fn currency_format(value: f32) -> String {
    format!("{:.2}", value)
}

/// Change NaiveDate to Utc beginning of day
pub fn naivedate_to_datetime_utc_start_of_day(date: &NaiveDate) -> DateTime<Utc> {
    DateTime::<Utc>::from_naive_utc_and_offset(date.and_hms_opt(0, 0, 0).unwrap(), Utc)
}

/// Change NaiveDate to Utc beginning of day
pub fn naivedate_to_datetime_utc_end_of_day(date: &NaiveDate) -> DateTime<Utc> {
    DateTime::<Utc>::from_naive_utc_and_offset(date.and_hms_opt(23, 59, 59).unwrap(), Utc)
}

/// Change string to markdown
pub fn markdown_to_html(markdown: &str) -> String {
    let parser = Parser::new(markdown);
    let mut html_output = String::new();
    html::push_html(&mut html_output, parser);
    html_output
}

