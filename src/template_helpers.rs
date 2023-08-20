use std::fmt::Write;

use actix_web_flash_messages::IncomingFlashMessages;
use serde_json::{Value, json};

use crate::utils::e500;

pub struct RenderTemplateParams<'a> {
    pub template: &'static str,
    pub handlebar: &'a actix_web::web::Data<handlebars::Handlebars<'a>>,
    pub incoming_flash_messages: Option<&'a IncomingFlashMessages>,
    pub template_data: Option<&'a Value>,
}

impl<'a> RenderTemplateParams<'a> {
    pub fn new(template: &'static str, handlebar: &'a actix_web::web::Data<handlebars::Handlebars<'a>>) -> Self {
        Self {
            template,
            handlebar,
            incoming_flash_messages: None,
            template_data: None,
        }
    }

    pub fn with_flash_messages(mut self, messages: &'a IncomingFlashMessages) -> Self {
        self.incoming_flash_messages = Some(messages);
        self
    }

    pub fn with_data(mut self, data: &'a Value) -> Self {
        self.template_data = Some(data);
        self
    }
}

pub fn render_content(render_template_params: &RenderTemplateParams<'_>) -> Result<String, actix_web::Error> {
    let mut flash_html = String::new();

    // Extracting the IncomingFlashMessages if it exists
    if let Some(flash_messages) = &render_template_params.incoming_flash_messages {
        for m in flash_messages.iter() {
            writeln!(flash_html, "<div>{}<div>", m.content()).map_err(e500)?;
        }
    }
    let default_data = json!({});
    let content_params = match &render_template_params.template_data {
        Some(data) => data,
        None => &default_data,
    };

    let content = render_template_params.handlebar.render(render_template_params.template, content_params).map_err(e500)?;
    let data = json!({
        "content": content,
        "flash_html": flash_html,
    });

    Ok(render_template_params.handlebar.render("base", &data).map_err(e500)?)
}

pub fn err_500_template<E: std::fmt::Display>(handlebar: &actix_web::web::Data<handlebars::Handlebars<'_>>, error: E) -> String {
    let error_description = format!("{}", error);
    handlebar.render("500", &json!({"error_description": error_description})).unwrap_or_else(|_| String::from("Internal Server Error"))
}

fn combine_json(a: &mut Value, b: &Value) {
    if let (Some(a_map), Some(b_map)) = (a.as_object_mut(), b.as_object()) {
        for (key, value) in b_map {
            a_map.insert(key.clone(), value.clone());
        }
    }
}

