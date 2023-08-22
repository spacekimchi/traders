use chrono::{Datelike, NaiveDate, Duration, DateTime, Utc, TimeZone};

pub fn excel_to_date(excel_date: i32) -> Option<NaiveDate> {
    let start_date_opt = NaiveDate::from_ymd_opt(1899, 12, 31); // Excel's epoch starts a day earlier

    match start_date_opt {
        Some(start_date) => {
            if excel_date >= 60 {
                // Account for Excel's bug with Feb 29, 1900
                Some(start_date + Duration::days(excel_date as i64 - 1))
            } else {
                Some(start_date + Duration::days(excel_date as i64))
            }
        },
        None => None
    }
}

pub fn get_current_year() -> i32 {
    let current_date = chrono::Utc::now();
    current_date.year()
}

/// Convert a NaiveDate to an Excel serial date
pub fn date_to_excel(date: &DateTime<Utc>) -> i32 {
    let excel_base_date = Utc.with_ymd_and_hms(1899, 12, 31, 0, 0, 0).unwrap(); // Using Dec 31, 1899 since Excel considers Jan 1, 1900 as day 1.
    let duration = *date - excel_base_date;
    duration.num_days() as i32
}


/// For converting year value into the excel value for the first day of the year
pub fn year_to_excel(year: i32) -> i32 {
    if year < 1900 {
        return -1; // Excel date starts from 1900
    }

    let years_diff = year - 1900;
    let mut days = years_diff * 365; // add 365 days for each year

    // Add an extra day for every leap year.
    for y in 1900..year {
        // 1900 is not a leap year, but there is an excel bug that counts this
        // as a leap year
        if y == 1900 || (y % 4 == 0 && (y % 100 != 0 || y % 400 == 0)) {
            days += 1;
        }
    }

    days as i32
}

pub fn is_leap_year(year: i32) -> bool {
    year == 1900 || (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0))
}

