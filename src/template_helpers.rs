use std::fmt::Write;

use actix_web_flash_messages::IncomingFlashMessages;
use serde_json::json;

use crate::utils::e500;

pub struct RenderTemplateParams<'a> {
    pub template: &'static str,
    pub handlebar: &'a actix_web::web::Data<handlebars::Handlebars<'a>>,
    pub incoming_flash_messages: Option<&'a IncomingFlashMessages>,
}

pub fn render_content(render_template_params: &RenderTemplateParams<'_>) -> Result<String, actix_web::Error> {
    let mut flash_html = String::new();

    // Extracting the IncomingFlashMessages if it exists
    if let Some(flash_messages) = &render_template_params.incoming_flash_messages {
        for m in flash_messages.iter() {
            writeln!(flash_html, "<div>{}<div>", m.content()).map_err(e500)?;
        }
    }
    let content = render_template_params.handlebar.render(render_template_params.template, &json!({})).map_err(e500)?;
    let data = json!({
        "content": content,
        "flash_html": flash_html,
    });

    Ok(render_template_params.handlebar.render("base", &data).map_err(e500)?)
}

pub fn err_500_template(handlebar: &actix_web::web::Data<handlebars::Handlebars<'_>>) -> String {
    handlebar.render("500", &json!({})).unwrap_or_else(|_| String::from("Internal Server Error"))
}

