//! src/routes/calendar/mod.rs
//!
//! This directory will hold all the files that have to do with pages under the /calendar url
//! Routes under this directory should be placed under the /calendar namespace in src/startup.rs
//!

use actix_web::{HttpResponse, get};
use actix_web::web::Data;
// For using the .month and .year methods
use chrono::{Datelike, Duration};
use chrono::prelude::*;

use serde::Serialize;

use crate::session_state::TypedSession;
use crate::excel_helpers;
use crate::startup::AppState;
use crate::template_helpers::{render_content, RenderTemplateParams, err_500_template};
use crate::db::models::trades;

/// URL: https://traders.jinz.co/calendar
#[get("")]
async fn get_calendar_root(tera_engine: Data<tera::Tera>, _session: TypedSession, state: Data<AppState>) -> HttpResponse {
    // Calculate the date 52 weeks ago
    let date_52_weeks_ago = Utc::now() - Duration::days(365);

    println!("\n\n\nDATE_52_WEEKS_AGO: {:?}n", date_52_weeks_ago);
    // Adjust to the beginning of that week (i.e., the previous Sunday)
    let days_since_last_sunday = date_52_weeks_ago.weekday().number_from_sunday() as i64 - 1;
    println!("\n\n\nDATE_52_WEEKS_AGO.WEEKDAY: {:?}n", date_52_weeks_ago.weekday());
    println!("DAYS_SINCE_LAST_SUNDAY: {:?}", days_since_last_sunday);
    let start_date = date_52_weeks_ago - Duration::days(days_since_last_sunday);
    println!("START_DATE: {:?}", start_date);

    let start_date_excel = excel_helpers::date_to_excel(&start_date);
    println!("START_DATE_EXCEL: {:?}\n\n\n", start_date_excel);

    match trades::get_trades_by_day_from(&state, start_date_excel).await {
        Ok(trades_by_day) => {
            //calendar_year_from_trades(&trades_by_day, this_year);
            let past_trades_in_weeks = calendar_trades_from_last_52_weeks(&trades_by_day, start_date_excel);
            let mut context = tera::Context::new();
            context.insert("trades", &trades_by_day);
            context.insert("past_trades_in_weeks", &past_trades_in_weeks);
            match render_content(&RenderTemplateParams::new("calendar/index.html", &tera_engine).with_context(&context)) {
                Ok(calendar_template) => HttpResponse::Ok().body(calendar_template),
                Err(e) => HttpResponse::InternalServerError().body(err_500_template(&tera_engine, e))
            }
        },
        Err(e) => HttpResponse::InternalServerError().body(err_500_template(&tera_engine, e))
    }
}

fn calendar_trades_from_last_52_weeks(trades: &Vec<trades::TradeInfoByDay>, start_date_excel: i32) -> Vec<TradesInWeek> {
    let mut trades_in_year: Vec<TradesInWeek> = Vec::new();

    // Today's date
    let today = Utc::now();
    let end_date_excel = excel_helpers::date_to_excel(&today);

    let mut trades_iter = trades.iter().peekable();
    let mut current_week = TradesInWeek::new();

    for cur_excel_date in (start_date_excel as i32)..=(end_date_excel as i32) {
        let cur_date_obj = excel_helpers::excel_to_date(cur_excel_date).unwrap();
        let day_of_week = cur_date_obj.weekday().number_from_sunday();
        println!("CUR_DATE_OBJ: {:?}", cur_date_obj);
        println!("CUR_DATE_OBJ.WEEKDAY: {:?}", cur_date_obj.weekday());
        println!("DAY_OF_WEEK: {:?}", day_of_week);

        // If it's a weekend, skip
        // 1 == sunday and 7 == saturday
        if day_of_week == 1 || day_of_week == 7 {
            continue;
        }

        // If a trade exists for the current date, pop it from the iterator
        let trade_info = if trades_iter.peek().is_some() && trades_iter.peek().unwrap().trade_day as i32 == cur_excel_date {
            Some(trades_iter.next().unwrap())
        } else {
            None
        };

        current_week.trades.push(TradingDay::new(trade_info, day_of_week));

        // If the current_week has 5 days or if we're in the current week (where we might not have reached 5 weekdays yet)
        if current_week.trades.len() == 5 || (cur_date_obj == today.naive_utc().date() && day_of_week == 5) {
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

#[derive(Debug, Serialize)]
struct TradingDay<'a> {
    pub trade_info: Option<&'a trades::TradeInfoByDay>,
    pub day_name: &'static str,
}

impl <'a>TradingDay<'_> {
    fn new(trade_info: Option<&'a trades::TradeInfoByDay>, day: u32) -> TradingDay<'a> {
        TradingDay {
            trade_info,
            day_name: get_day_name_from_number(day),
        }
    }
}

fn get_day_name_from_number(mut day: u32) -> &'static str {
    let day_strings = vec!("INVALID",
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

fn _get_month_name_from_number(mut month: i32) -> &'static str {
    let months_to_string = vec!("January",
                                           "Februrary",
                                           "March",
                                           "April",
                                           "May",
                                           "June",
                                           "July",
                                           "August",
                                           "September",
                                           "October",
                                           "November",
                                           "December",
                                           "INVAID MONTH");

    if month < 0 || month >= months_to_string.len() as i32 {
        month = 12;
    }
    months_to_string[month as usize]
}
