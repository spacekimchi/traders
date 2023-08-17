use std::fmt::Write;

use actix_web_flash_messages::IncomingFlashMessages;
use actix_web::{ResponseError, HttpResponse};
use serde_json::json;

use crate::utils::error_chain_fmt;
use crate::errors;

pub struct RenderTemplateParams<'a> {
    pub template: &'static str,
    pub handlebar: &'a actix_web::web::Data<handlebars::Handlebars<'static>>,
    pub incoming_flash_messages: Option<&'a IncomingFlashMessages>,
}

#[derive(thiserror::Error)]
pub enum TemplateError {
    #[error("Failed to render template")]
    RenderError(#[from] handlebars::RenderError),
}

impl std::fmt::Debug for TemplateError {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        error_chain_fmt(self, f)
    }
}

impl ResponseError for TemplateError {
    fn error_response(&self) -> HttpResponse {
        let error_message = format!("{}", self);
        let error_response = errors::ApiError { message: error_message };

        match self {
            // What we really need here is to render a template based on the error
            // Sometthing like
            //   TemplateError::RenderError(_) => HttpResponse::InternalServerError().json(template_helpers::err_500_template),
            TemplateError::RenderError(_) => HttpResponse::InternalServerError().json(error_response),
        }
    }
}


pub fn render_content(render_template_params: &RenderTemplateParams<'_>) -> Result<String, TemplateError> {
    let mut flash_html = String::new();

    // Extracting the IncomingFlashMessages if it exists
    if let Some(flash_messages) = &render_template_params.incoming_flash_messages {
        for m in flash_messages.iter() {
            writeln!(flash_html, "<div>{}<div>", m.content()).unwrap();
        }
    }
    let content = render_template_params.handlebar.render(render_template_params.template, &json!({}))?;
    let data = json!({
        "content": content,
        "flash_html": flash_html,
    });

    Ok(render_template_params.handlebar.render("base", &data)?)
}

pub fn render_500_err() -> String {
    let content = render_template_params.handlebar.render("500", &json!({})).context("rendering error");
}

