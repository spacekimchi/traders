use std::fmt::Write;

use actix_web_flash_messages::IncomingFlashMessages;

use crate::utils::e500;

pub struct RenderTemplateParams<'a> {
    pub template_path: &'static str,
    pub tera_store: &'a actix_web::web::Data<tera::Tera>,
    pub incoming_flash_messages: Option<&'a IncomingFlashMessages>,
    pub template_context: Option<&'a tera::Context>,
}

impl<'a> RenderTemplateParams<'a> {
    pub fn new(template_path: &'static str, tera_store: &'a actix_web::web::Data<tera::Tera>) -> Self {
        Self {
            template_path,
            tera_store,
            incoming_flash_messages: None,
            template_context: None,
        }
    }

    pub fn with_flash_messages(mut self, messages: &'a IncomingFlashMessages) -> Self {
        self.incoming_flash_messages = Some(messages);
        self
    }

    pub fn with_context(mut self, data: &'a tera::Context) -> Self {
        self.template_context = Some(data);
        self
    }
}

pub fn render_content(render_template_params: &RenderTemplateParams<'_>) -> Result<String, actix_web::Error> {
    // First set the context data
    let mut context: tera::Context;
    if let Some(data) = render_template_params.template_context {
        context = data.clone(); // assuming `tera::Context` implements the Clone trait
    } else {
        context = tera::Context::new();
    }

    // Setting the flash message can be extracted out into it's own method
    let mut flash_html = String::new();

    // Extracting the IncomingFlashMessages if it exists
    if let Some(flash_messages) = &render_template_params.incoming_flash_messages {
        for m in flash_messages.iter() {
            writeln!(flash_html, "<div>{}<div>", m.content()).map_err(e500)?;
        }
    }

    context.insert("flash_html", &flash_html);

    Ok(render_template_params.tera_store.render(&render_template_params.template_path, &context).map_err(e500)?)
}

pub fn err_500_template<E: std::fmt::Display>(tr: &actix_web::web::Data<tera::Tera>, error: E) -> String {
    let error_description = format!("{}", error);
    let mut context = tera::Context::new();
    context.insert("error_description", &error_description);
    tr.render("500.html", &context).unwrap_or_else(|_| String::from("Internal Server Error"))
}
