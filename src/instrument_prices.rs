//! src/instrument_prices.rs
//! The prices in here represent price per tick
//!

pub fn by_symbol(symbol: &str) -> (f32, f32) {
    match symbol {
        "ES" => ES,
        "MES" => MES,
        "NQ" => NQ,
        "MNQ" => MNQ,
        "GC" => GC,
        "MGC" => MGC,
        &_ => (0.0, 0.0),
    }
}

/// (i32, f32) = (ticks in a point, price per tick)
pub const ES: (f32, f32) = (4.0, 12.5);
pub const MES: (f32, f32) = (4.0, 12.5);
pub const NQ: (f32, f32) = (4.0, 12.5);
pub const MNQ: (f32, f32) = (4.0, 12.5);
pub const GC: (f32, f32) = (10.0, 0.1);
pub const MGC: (f32, f32) = (10.0, 0.1);

