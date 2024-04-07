//! src/routes/homepage.rs
//!
//! This file is used to create a route for the homepage
//! The homepage template can be found in static/templates/index.html
use actix_web::{get, HttpResponse, web};
use actix_web::web::Data;
use actix_web_flash_messages::IncomingFlashMessages;
use chrono::Datelike;
use serde::Serialize;

use crate::template_helpers::{RenderTemplateParams, render_content, err_500_template};
use crate::startup::AppState;
use crate::excel_helpers;
use crate::db::models::trades;
use crate::db::models::accounts;
use crate::session_state::TypedSession;
use crate::utils::e500;

#[derive(Debug, Serialize, Clone)]
struct TradingDay<'a> {
    pub trade_info: Option<&'a trades::TradeInfoByDay>,
    pub day_name: &'static str,
    pub date_number: u32,
    pub padding_day: bool,
    pub class_list: Vec<&'static str>,
}

impl <'a>TradingDay<'_> {
    fn new(trade_info: Option<&'a trades::TradeInfoByDay>, day: u32, date_number: u32) -> TradingDay<'a> {
        TradingDay {
            trade_info,
            day_name: get_day_name_from_number(day),
            date_number,
            class_list: get_class_list_for_trading_day(&trade_info),
            padding_day: false,
        }
    }

    fn _with_padding_true(mut self) -> Self {
        self.padding_day = true;
        self.class_list.push("padding-day");
        self
    }

    fn _with_mini_month(mut self) -> Self {
        self.class_list.push("mini-month-day");
        self
    }

    fn with_mini_day(mut self) -> Self {
        self.class_list.push("mini-day");
        self
    }
}

#[derive(Debug, Serialize)]
struct TradesInWeek<'a> {
    pub trades: Vec<TradingDay<'a>>,
}

impl <'a>TradesInWeek<'_> {
    fn new() -> TradesInWeek<'a> {
        TradesInWeek {
            trades: Vec::<TradingDay>::new(),
        }
    }
}

// Macro documentation can be found in the actix_web_codegen crate
//
#[get("/")]
async fn index(tera_engine: web::Data<tera::Tera>, flash_messages: IncomingFlashMessages, session: TypedSession, state: Data<AppState>) -> Result<HttpResponse, actix_web::Error> {
    let user_id = match session
        .get_user_id()
        .map_err(e500)? {
            Some(user_id) => user_id,
            // This None will grab the default user_id, which is my account
            None => crate::db::models::users::get_user_from_database_by_ninja_trader_id(&state.db, &"YourNinjaTraderIdString".to_string()).await?.id
        };
    let year_in_weeks = 52;
    let year_of_trades = excel_helpers::get_start_of_n_weeks_ago(year_in_weeks);
    let trade_search_params = trades::TradeSearchParams::default()
        .start_date(year_of_trades);
    let trades_by_day = match trades::get_trades_by_day_from(&state.db, &trade_search_params).await {
        Ok(trades_by_day) => trades_by_day,
        Err(e) => return Ok(HttpResponse::InternalServerError().body(err_500_template(&tera_engine, e)))
    };
    let last_52_weeks_of_trades = calendar_trades_from_last_52_weeks(&trades_by_day, year_of_trades);
    let accounts_for_pnl_chart = accounts::fetch_accounts_for_pnl_charts(&state.db, &user_id).await.map_err(e500)?;

    let mut context = tera::Context::new();
    context.insert("name", "Traders");
    context.insert("last_52_weeks_of_trades", &last_52_weeks_of_trades);
    context.insert("accounts_for_pnl_chart", &accounts_for_pnl_chart);
    let content = render_content(&RenderTemplateParams::new(&"homepage/index.html", &tera_engine)
                                         .with_flash_messages(&flash_messages)
                                         .with_context(&context)
                                         .with_session(&session))?;

    Ok(HttpResponse::Ok().content_type("text/html").body(content))
}

// This will build trades into a display like the commit history you see on github,
// except this doesnt have weekends
fn calendar_trades_from_last_52_weeks(trades: &Vec<trades::TradeInfoByDay>, start_date_excel: u32) -> Vec<TradesInWeek> {
    let mut trades_in_year: Vec<TradesInWeek> = Vec::new();

    // Today's date
    let today = chrono::Local::now().date_naive();
    let end_date_excel = excel_helpers::date_to_excel(&today);

    let mut trades_iter = trades.iter().peekable();
    let mut current_week = TradesInWeek::new();

    for cur_excel_date in (start_date_excel)..=(end_date_excel) {
        let cur_date_obj = excel_helpers::excel_to_date(cur_excel_date).unwrap();
        let day_of_week = cur_date_obj.weekday().number_from_sunday();

        // If it's a weekend, skip
        // 1 == sunday and 7 == saturday
        if day_of_week == 1 || day_of_week == 7 {
            continue;
        }

        // If a trade exists for the current date, pop it from the iterator
        let trade_info = if trades_iter.peek().is_some() && trades_iter.peek().unwrap().trade_day as u32  == cur_excel_date {
            Some(trades_iter.next().unwrap())
        } else {
            None
        };

        current_week.trades.push(TradingDay::new(trade_info, day_of_week, cur_date_obj.day()).with_mini_day());

        // If the current_week has 5 days or if we're in the current week (where we might not have reached 5 weekdays yet)
        if current_week.trades.len() == 5 || (cur_date_obj == today && day_of_week == 5) {
            trades_in_year.push(current_week);
            current_week = TradesInWeek::new();
        }
    }

    // If there are any remaining days in the current_week, push it to trades_in_year
    if !current_week.trades.is_empty() {
        trades_in_year.push(current_week);
    }

    trades_in_year
}

fn get_day_name_from_number(mut day: u32) -> &'static str {
    let day_strings = vec!("INVALID DAY",
                                      "Sunday",
                                      "Monday",
                                      "Tuesday",
                                      "Wednesday",
                                      "Thursday",
                                      "Friday",
                                      "Saturday");
    if day >= day_strings.len() as u32 {
        day = 0;
    }
    day_strings[day as usize]
}

/// This is a helper method to set the class list for the calendar day
/// Doing this makes it easy to just call a join on the tera templates to generate the classes in
/// the html
pub fn get_class_list_for_trading_day<'a>(trade_info: &Option<&'a trades::TradeInfoByDay>) -> Vec<&'static str> {
    let mut class_list = vec![];
    match trade_info {
        Some(trade) => {
            if trade.total_pnl > 0.0 {
                class_list.push("green-day");
            } else {
                class_list.push("red-day");
            }
        },
        None => {}
    }
    class_list
}
