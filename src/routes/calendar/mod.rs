//! src/routes/calendar/mod.rs
//!
//! This directory will hold all the files that have to do with pages under the /calendar url
//! Routes under this directory should be placed under the /calendar namespace in src/startup.rs
//!
//! TODO:
//!   - Replace all of the hardcoded strings
//!     - Quite a few of them are errors, we need to create error types
//!
use std::collections::HashMap;

use actix_web::{HttpResponse, get};
use actix_web::web::{Data, Query};
use chrono::{Datelike, NaiveDate, Duration, Weekday, Local, DateTime, Utc};
use serde::{Serialize, Deserialize};

use crate::session_state::TypedSession;
use crate::excel_helpers;
use crate::startup::AppState;
use crate::template_helpers::{render_content, RenderTemplateParams, err_500_template};
use crate::db::models::trades;
use crate::utils::currency_format;

#[derive(Debug, Serialize)]
struct TradesInMonth<'a> {
    pub trades: Vec<TradesInWeek<'a>>,
    pub name: &'static str,
    pub year: i32,
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

    fn with_padding_true(mut self) -> Self {
        self.padding_day = true;
        self.class_list.push("padding-day");
        self
    }

    fn with_mini_month(mut self) -> Self {
        self.class_list.push("mini-month-day");
        self
    }

    fn with_mini_day(mut self) -> Self {
        self.class_list.push("mini-day");
        self
    }
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

/// The start_date and end_date formats should be "YEAR-MONTH-DAY" (2023-12-31)
#[derive(Debug, Serialize, Deserialize)]
pub struct CalendarQueryStrings {
    pub start_date: Option<String>,
    pub end_date: Option<String>,
}

/// URL: https://traders.jinz.co/calendar
#[get("")]
async fn get_calendar_root(tera_engine: Data<tera::Tera>, session: TypedSession, state: Data<AppState>, query: Query<CalendarQueryStrings>) -> HttpResponse {
    // We need these to grab the start date and end date from the params
    // Or set it to the first day of the year
    let today = Local::now().date_naive();
    let start_date = match &query.start_date {
        Some(date) => NaiveDate::parse_from_str(date, "%Y-%m-%d").unwrap_or(NaiveDate::from_ymd_opt(today.year(), 1, 1).unwrap()),
        _ => NaiveDate::from_ymd_opt(today.year(), 1, 1).unwrap()
    };
    
    let end_date = match &query.end_date {
        Some(date) => NaiveDate::parse_from_str(date, "%Y-%m-%d").unwrap_or(today),
        _ => today
    };

    let year_in_weeks = 52;
    let year_of_trades = excel_helpers::get_start_of_n_weeks_ago(year_in_weeks);
    let start_date_excel = excel_helpers::date_to_excel(&start_date);
    let end_date_excel = excel_helpers::date_to_excel(&end_date);
    let trades_by_day = match trades::get_trades_by_day_from(&state.db, year_of_trades).await {
        Ok(trades_by_day) => trades_by_day,
        Err(e) => return HttpResponse::InternalServerError().body(err_500_template(&tera_engine, e))
    };
    let trades_by_day_in_range = match trades::get_trades_by_day_in_range(&state.db, start_date_excel, end_date_excel).await {
        Ok(trades_by_day_in_range) => trades_by_day_in_range,
        Err(e) => return HttpResponse::InternalServerError().body(err_500_template(&tera_engine, e))
    };
    let todays_date = chrono::Local::now().date_naive();
    let last_52_weeks_of_trades = calendar_trades_from_last_52_weeks(&trades_by_day, year_of_trades);
    let trades_by_day_in_range_ref = trades_by_day_in_range.iter().collect();
    let trades_calendar = match get_trades_in_year_by_days_in_month(&trades_by_day_in_range_ref, todays_date.year()) {
        Ok(trades_calendar) => trades_calendar,
        Err(e) => return HttpResponse::InternalServerError().body(err_500_template(&tera_engine, e))
    };
    let statistics = statistics_calculations(&trades_by_day_in_range_ref);

    let mut context = tera::Context::new();
    context.insert("statistics", &statistics);
    context.insert("trades", &trades_by_day);
    context.insert("trades_by_day_in_range", &trades_by_day_in_range);
    context.insert("last_52_weeks_of_trades", &last_52_weeks_of_trades);
    context.insert("trades_calendar", &trades_calendar);

    match render_content(&RenderTemplateParams::new("calendar/index.html", &tera_engine)
                         .with_context(&context)
                         .with_session(&session)) {
        Ok(calendar_template) => HttpResponse::Ok().body(calendar_template),
        Err(e) => HttpResponse::InternalServerError().body(err_500_template(&tera_engine, e))
    }
}

fn _total_pnl(trades_by_day: &Vec<&trades::TradeInfoByDay>) -> f32 {
    trades_by_day.iter().map(|trade| trade.total_pnl).sum()
}

#[derive(Debug, Serialize)]
struct TradeStatistics {
    pub total_pnl: String,
    pub total_trades: i64,
}

fn statistics_calculations(trades_by_day: &Vec<&trades::TradeInfoByDay>) -> TradeStatistics {
    let mut sum = 0.0;
    let mut total_trades = 0;
    for trade in trades_by_day {
        sum += trade.total_pnl;
        total_trades += trade.number_of_trades;
    }

    TradeStatistics {
        total_pnl: currency_format(sum),
        total_trades
    }
}

// This will build trades into a display like the commit history you see on github,
// except this doesnt have weekends
fn calendar_trades_from_last_52_weeks(trades: &Vec<trades::TradeInfoByDay>, start_date_excel: DateTime<Utc>) -> Vec<TradesInWeek> {
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

/// This function is for building trades into a calendar style for displaying on the calendar
/// page.
///
/// Params:
/// trades: &HashMap<i32, &Vec<trades::TradeInfoByDay>>
///   - key: the day in excel serial date format
///   - value: vector of trades in that day
fn get_trades_in_year_by_days_in_month<'a>(trades: &Vec<&'a trades::TradeInfoByDay>, year: i32) -> Result<Vec<TradesInMonth<'a>>, &'static str> {
    let mut trades_hash: HashMap<u32, &'a trades::TradeInfoByDay> = HashMap::new();
    for trade in trades {
        trades_hash.insert(trade.trade_day as u32, trade);
    }
    let trades_by_month_in_year = build_year(year, &trades_hash)?;
    Ok(trades_by_month_in_year)
}

fn build_year<'a>(year: i32, trades: &HashMap<u32, &'a trades::TradeInfoByDay>) -> Result<Vec<TradesInMonth<'a>>, &'static str> {
    let trades_in_year: Result<Vec<TradesInMonth>, &'static str> = (1..=12)
        .map(|month| build_month(year, month, trades))
        .collect();

    trades_in_year
}

fn build_month<'a>(year: i32, month: u32, trades: &HashMap<u32, &'a trades::TradeInfoByDay>) -> Result<TradesInMonth<'a>, &'static str> {
    let mut trades_in_month: Vec<TradingDay> = Vec::new();
    // NaiveDate returns a date that looks like 12/24/1991. There is no time association
    let first_day_of_month = NaiveDate::from_ymd_opt(year, month, 1).ok_or("Unable to set first_weekday_of_month in build_month")?;
    // In chrono::Weekday, numbering starts with 0 on Monday up to 6 on Sunday
    // [Mon, Tue, Wed, Thu, Fri, Sat, Sun]
    // This will make sure the first_weekday_of_month always starts on a Monday
    let mut padding_day = match first_day_of_month.weekday() {
        Weekday::Mon => first_day_of_month,
        Weekday::Tue => first_day_of_month - Duration::days(1),
        Weekday::Wed => first_day_of_month - Duration::days(2),
        Weekday::Thu => first_day_of_month - Duration::days(3),
        Weekday::Fri => first_day_of_month - Duration::days(4),
        Weekday::Sat => first_day_of_month + Duration::days(2),
        Weekday::Sun => first_day_of_month + Duration::days(1),
    };
    while padding_day < first_day_of_month {
        match padding_day.weekday() {
            Weekday::Sat | Weekday::Sun => {},
            _ => trades_in_month.push(TradingDay::new(None, padding_day.weekday().number_from_sunday(), padding_day.day())
                                      .with_padding_true()
                                      .with_mini_month())
        }
        padding_day += Duration::days(1);
    }

    let next_month_start = if month == 12 {
        NaiveDate::from_ymd_opt(year + 1, 1, 1).ok_or("Unable to set next_month_start in build_month")?
    } else {
        NaiveDate::from_ymd_opt(year, month + 1, 1).ok_or("Unable to set next_month_start in build_month")?
    };

    // These should be the days of the current month we are building
    // On weekdays we want to add trades to TradeInfoByDay
    // We only want to collect weekdays
    let mut current_day = first_day_of_month;
    while current_day < next_month_start {
        match current_day.weekday() {
            Weekday::Sat | Weekday::Sun => {},
            _ => { 
                let excel_date = excel_helpers::date_to_excel(&current_day);
                let days_from_sunday = current_day.weekday().number_from_sunday();
                let date_number = current_day.day();
                let trading_day = match trades.get(&excel_date) {
                    Some(trade_info) => TradingDay::new(Some(*trade_info), days_from_sunday, date_number).with_mini_month(),
                    None => TradingDay::new(None, days_from_sunday, date_number).with_mini_month()
                };
                trades_in_month.push(trading_day);
            }
        }
        current_day += Duration::days(1);
    }
    
    // Padding for the remaining days in the month calendar
    let last_day_of_month = next_month_start - Duration::days(1);
    let last_weekday_of_month = match last_day_of_month.weekday() {
        Weekday::Mon => last_day_of_month + Duration::days(4),
        Weekday::Tue => last_day_of_month + Duration::days(3),
        Weekday::Wed => last_day_of_month + Duration::days(2),
        Weekday::Thu => last_day_of_month + Duration::days(1),
        Weekday::Fri => last_day_of_month,
        Weekday::Sat => last_day_of_month - Duration::days(1),
        Weekday::Sun => last_day_of_month - Duration::days(2),
    };
    while current_day <= last_weekday_of_month {
        trades_in_month.push(TradingDay::new(None, current_day.weekday().number_from_sunday(), current_day.day()).with_padding_true());
        current_day += Duration::days(1);
    }


    let mut weeks = vec![];
    for chunk in trades_in_month.chunks(5) { // Now the chunk size remains 5 for weekdays
        weeks.push(TradesInWeek { trades: chunk.to_vec() });
    }

    Ok(TradesInMonth { trades: weeks, name: get_month_name_from_number(month), year })
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

fn get_month_name_from_number(mut month: u32) -> &'static str {
    let months_to_string = vec!("INVALID MONTH",
                                           "January",
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
                                           "December");

    if month >= months_to_string.len() as u32 {
        month = 12;
    }
    months_to_string[month as usize]
}
