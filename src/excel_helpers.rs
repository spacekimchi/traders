use chrono::{Datelike, NaiveDate, Duration, DateTime, Utc, TimeZone};

const EXCEL_BUG_DATE: u32 = 60;

pub fn excel_to_date(excel_date: u32) -> Option<NaiveDate> {
    let start_date_opt = NaiveDate::from_ymd_opt(1899, 12, 31); // Excel's epoch starts a day earlier

    match start_date_opt {
        Some(start_date) => {
            if excel_date >= EXCEL_BUG_DATE {
                // Account for Excel's bug with Feb 29, 1900
                Some(start_date + Duration::days(excel_date as i64 - 1))
            } else {
                Some(start_date + Duration::days(excel_date as i64))
            }
        },
        None => None
    }
}

pub fn excel_to_utc(excel_date: f64) -> DateTime<Utc> {
    // Excel's base date for Windows (December 30, 1899)
    let base_date = NaiveDate::from_ymd_opt(1899, 12, 30).unwrap();

    // Calculate the number of days and fractional days from the Excel date
    let days = excel_date.trunc() as i64;
    let fractional_days = excel_date.fract();

    // Convert fractional days to seconds (1 day = 86400 seconds)
    let seconds_in_day = 86_400.0;
    let seconds = (fractional_days * seconds_in_day).round() as i64;

    // Create a NaiveDateTime from the base_date plus the Excel days
    let naive_date_time = base_date.and_hms_opt(0, 0, 0).unwrap() + Duration::days(days) + Duration::seconds(seconds);

    // Convert to DateTime<Utc>
    Utc.from_utc_datetime(&naive_date_time)
}

/// This function will go back weeks_ago and grab the start of that week
/// Grabbing dates that start at the start of the week is helpful because it
/// allows us to grab trades starting at the start of a week
pub fn get_start_of_n_weeks_ago(weeks_ago: u32) -> u32 {
    // Calculate the date 52 weeks ago
    let date_52_weeks_ago = chrono::Local::now().date_naive() - Duration::weeks(weeks_ago as i64);

    // Adjust to the start of that week (i.e., the previous Sunday)
    let days_since_last_sunday = date_52_weeks_ago.weekday().number_from_sunday() as i64 - 1;
    let start_date = date_52_weeks_ago - Duration::days(days_since_last_sunday);

    date_to_excel(&start_date)
}

/// Convert a NaiveDate to an Excel serial date
pub fn date_to_excel(date: &NaiveDate) -> u32 {
    // Using Dec 31, 1899 since Excel considers Jan 1, 1900 as day 1.
    let excel_base_date = NaiveDate::from_ymd_opt(1899, 12, 31).unwrap();
    let duration = *date - excel_base_date;
    let mut excel_date = duration.num_days() as u32;

    // Accounting for Excel's leap year bug
    if excel_date >= EXCEL_BUG_DATE {
        excel_date += 1;
    }

    excel_date
}


/// For converting year value into the excel value for the first day of the year
pub fn year_to_excel(year: i32) -> Result<u32, &'static str> {
    if year < 1900 {
        return Err("Excel dates start at year 1900");
    }

    let years_diff = year - 1900;
    let mut days = years_diff * 365; // add 365 days for each year

    // Add an extra day for every leap year.
    for y in 1900..year {
        // 1900 is not a leap year, but there is an excel bug that counts this
        // as a leap year
        if is_leap_year(y) {
            days += 1;
        }
    }

    Ok(days as u32)
}

pub fn is_leap_year(year: i32) -> bool {
    year == 1900 || (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0))
}

