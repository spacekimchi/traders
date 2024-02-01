//! tests/api/executions.rs
//!
//! Current tests
//!
//! [
//!     {"id":1881,"account_name":"Sim101","order_id":"5cce3343ce6947938138c00ae37c630a","instrument_name":"ES","fill_time":45293.641572152781,"commission":2.09,"price":4787,"is_buy":true,"quantity":1},
//!     {"id":1882,"account_name":"Sim101","order_id":"caed33088f2c469ab62df2b8961c74b2","instrument_name":"ES","fill_time":45293.641894131943,"commission":2.09,"price":4787.25,"is_buy":false,"quantity":1},
//!     {"id":1883,"account_name":"Sim101","order_id":"3d63329bb3d54afc8e65b90aacbf4e19","instrument_name":"ES","fill_time":45293.647935810186,"commission":2.09,"price":4788,"is_buy":true,"quantity":1},
//!     {"id":1884,"account_name":"Sim101","order_id":"3d63329bb3d54afc8e65b90aacbf4e19","instrument_name":"ES","fill_time":45293.647939467592,"commission":14.629999999999999,"price":4788,"is_buy":true,"quantity":7},
//!     {"id":1885,"account_name":"Sim101","order_id":"4e1c7b25bb474aa19317ba3267e6ebd6","instrument_name":"ES","fill_time":45293.648027222225,"commission":2.09,"price":4787.75,"is_buy":false,"quantity":1},
//!     {"id":1886,"account_name":"Sim101","order_id":"4e1c7b25bb474aa19317ba3267e6ebd6","instrument_name":"ES","fill_time":45293.648049467593,"commission":14.629999999999999,"price":4787.75,"is_buy":false,"quantity":7},
//!     {"id":1887,"account_name":"Sim101","order_id":"67e16deb3b304c9b9af6e98752389b24","instrument_name":"ES","fill_time":45293.670687280093,"commission":20.9,"price":4788.25,"is_buy":true,"quantity":10},
//!     {"id":1888,"account_name":"Sim101","order_id":"058e852a6c3c4c79ace323fdd47d38b1","instrument_name":"ES","fill_time":45293.670729861115,"commission":2.09,"price":4788.25,"is_buy":false,"quantity":1},
//!     {"id":1889,"account_name":"Sim101","order_id":"058e852a6c3c4c79ace323fdd47d38b1","instrument_name":"ES","fill_time":45293.670739629626,"commission":12.54,"price":4788.25,"is_buy":false,"quantity":6},
//!     {"id":1890,"account_name":"Sim101","order_id":"058e852a6c3c4c79ace323fdd47d38b1","instrument_name":"ES","fill_time":45293.670740393522,"commission":6.27,"price":4788.25,"is_buy":false,"quantity":3},
//!     {"id":1891,"account_name":"Sim101","order_id":"215e1a7cb4a7480b958d9d7fe40355c1","instrument_name":"ES","fill_time":45293.680701053243,"commission":2.09,"price":4788.25,"is_buy":true,"quantity":1},
//!     {"id":1892,"account_name":"Sim101","order_id":"215e1a7cb4a7480b958d9d7fe40355c1","instrument_name":"ES","fill_time":45293.680702731479,"commission":8.36,"price":4788.25,"is_buy":true,"quantity":4},
//!     {"id":1893,"account_name":"Sim101","order_id":"215e1a7cb4a7480b958d9d7fe40355c1","instrument_name":"ES","fill_time":45293.680702754631,"commission":6.27,"price":4788.25,"is_buy":true,"quantity":3},
//!     {"id":1894,"account_name":"Sim101","order_id":"215e1a7cb4a7480b958d9d7fe40355c1","instrument_name":"ES","fill_time":45293.680719826392,"commission":2.09,"price":4788.25,"is_buy":true,"quantity":1},
//!     {"id":1895,"account_name":"Sim101","order_id":"215e1a7cb4a7480b958d9d7fe40355c1","instrument_name":"ES","fill_time":45293.680720555552,"commission":2.09,"price":4788.25,"is_buy":true,"quantity":1},
//!     {"id":1896,"account_name":"Sim101","order_id":"b88a8845372741f98f627d99980158d9","instrument_name":"ES","fill_time":45293.6808259838,"commission":2.09,"price":4788,"is_buy":false,"quantity":1},
//!     {"id":1897,"account_name":"Sim101","order_id":"b88a8845372741f98f627d99980158d9","instrument_name":"ES","fill_time":45293.680827777775,"commission":2.09,"price":4788.25,"is_buy":false,"quantity":1},
//!     {"id":1898,"account_name":"Sim101","order_id":"b88a8845372741f98f627d99980158d9","instrument_name":"ES","fill_time":45293.680828310185,"commission":8.36,"price":4788.25,"is_buy":false,"quantity":4},
//!     {"id":1899,"account_name":"Sim101","order_id":"e9c1da6faa3d452ab348b06bd4a864f4","instrument_name":"ES","fill_time":45293.68089009259,"commission":2.09,"price":4788.25,"is_buy":true,"quantity":1},
//!     {"id":1900,"account_name":"Sim101","order_id":"e9c1da6faa3d452ab348b06bd4a864f4","instrument_name":"ES","fill_time":45293.680909513889,"commission":2.09,"price":4788.5,"is_buy":true,"quantity":1},
//!     {"id":1901,"account_name":"Sim101","order_id":"e9c1da6faa3d452ab348b06bd4a864f4","instrument_name":"ES","fill_time":45293.680910023148,"commission":2.09,"price":4788.25,"is_buy":true,"quantity":1},
//!     {"id":1902,"account_name":"Sim101","order_id":"482225b6be994185adcfac1922a0c013","instrument_name":"ES","fill_time":45293.681051944448,"commission":2.09,"price":4788,"is_buy":false,"quantity":1},
//!     {"id":1903,"account_name":"Sim101","order_id":"482225b6be994185adcfac1922a0c013","instrument_name":"ES","fill_time":45293.681054976849,"commission":2.09,"price":4788,"is_buy":false,"quantity":1},
//!     {"id":1904,"account_name":"Sim101","order_id":"482225b6be994185adcfac1922a0c013","instrument_name":"ES","fill_time":45293.68105550926,"commission":6.27,"price":4788,"is_buy":false,"quantity":3},
//!     {"id":1905,"account_name":"Sim101","order_id":"56ecb365e917499d840859158c15cc1a","instrument_name":"ES","fill_time":45293.681087974539,"commission":4.18,"price":4788,"is_buy":false,"quantity":2}
//! ]
//!
//!

use crate::helpers::spawn_app;

#[actix_web::test]
async fn execution_create_success() {
    let app = spawn_app().await;
    let body = serde_json::json!([
                                 {"id":1881,"account_name":"Sim101","order_id":"5cce3343ce6947938138c00ae37c630a","instrument_name":"ES","fill_time":45293.641572152781,"commission":2.09,"price":4787,"is_buy":true,"quantity":1},
                                 {"id":1882,"account_name":"Sim101","order_id":"caed33088f2c469ab62df2b8961c74b2","instrument_name":"ES","fill_time":45293.641894131943,"commission":2.09,"price":4787.25,"is_buy":false,"quantity":1},
                                 {"id":1883,"account_name":"Sim101","order_id":"3d63329bb3d54afc8e65b90aacbf4e19","instrument_name":"ES","fill_time":45293.647935810186,"commission":2.09,"price":4788,"is_buy":true,"quantity":1},
                                 {"id":1884,"account_name":"Sim101","order_id":"3d63329bb3d54afc8e65b90aacbf4e19","instrument_name":"ES","fill_time":45293.647939467592,"commission":14.629999999999999,"price":4788,"is_buy":true,"quantity":7},
                                 {"id":1885,"account_name":"Sim101","order_id":"4e1c7b25bb474aa19317ba3267e6ebd6","instrument_name":"ES","fill_time":45293.648027222225,"commission":2.09,"price":4787.75,"is_buy":false,"quantity":1},
                                 {"id":1886,"account_name":"Sim101","order_id":"4e1c7b25bb474aa19317ba3267e6ebd6","instrument_name":"ES","fill_time":45293.648049467593,"commission":14.629999999999999,"price":4787.75,"is_buy":false,"quantity":7},
                                 {"id":1887,"account_name":"Sim101","order_id":"67e16deb3b304c9b9af6e98752389b24","instrument_name":"ES","fill_time":45293.670687280093,"commission":20.9,"price":4788.25,"is_buy":true,"quantity":10},
                                 {"id":1888,"account_name":"Sim101","order_id":"058e852a6c3c4c79ace323fdd47d38b1","instrument_name":"ES","fill_time":45293.670729861115,"commission":2.09,"price":4788.25,"is_buy":false,"quantity":1},
                                 {"id":1889,"account_name":"Sim101","order_id":"058e852a6c3c4c79ace323fdd47d38b1","instrument_name":"ES","fill_time":45293.670739629626,"commission":12.54,"price":4788.25,"is_buy":false,"quantity":6},
                                 {"id":1890,"account_name":"Sim101","order_id":"058e852a6c3c4c79ace323fdd47d38b1","instrument_name":"ES","fill_time":45293.670740393522,"commission":6.27,"price":4788.25,"is_buy":false,"quantity":3},
                                 {"id":1891,"account_name":"Sim101","order_id":"215e1a7cb4a7480b958d9d7fe40355c1","instrument_name":"ES","fill_time":45293.680701053243,"commission":2.09,"price":4788.25,"is_buy":true,"quantity":1},
                                 {"id":1892,"account_name":"Sim101","order_id":"215e1a7cb4a7480b958d9d7fe40355c1","instrument_name":"ES","fill_time":45293.680702731479,"commission":8.36,"price":4788.25,"is_buy":true,"quantity":4},
                                 {"id":1893,"account_name":"Sim101","order_id":"215e1a7cb4a7480b958d9d7fe40355c1","instrument_name":"ES","fill_time":45293.680702754631,"commission":6.27,"price":4788.25,"is_buy":true,"quantity":3},
                                 {"id":1894,"account_name":"Sim101","order_id":"215e1a7cb4a7480b958d9d7fe40355c1","instrument_name":"ES","fill_time":45293.680719826392,"commission":2.09,"price":4788.25,"is_buy":true,"quantity":1},
                                 {"id":1895,"account_name":"Sim101","order_id":"215e1a7cb4a7480b958d9d7fe40355c1","instrument_name":"ES","fill_time":45293.680720555552,"commission":2.09,"price":4788.25,"is_buy":true,"quantity":1},
                                 {"id":1896,"account_name":"Sim101","order_id":"b88a8845372741f98f627d99980158d9","instrument_name":"ES","fill_time":45293.6808259838,"commission":2.09,"price":4788,"is_buy":false,"quantity":1},
                                 {"id":1897,"account_name":"Sim101","order_id":"b88a8845372741f98f627d99980158d9","instrument_name":"ES","fill_time":45293.680827777775,"commission":2.09,"price":4788.25,"is_buy":false,"quantity":1},
                                 {"id":1898,"account_name":"Sim101","order_id":"b88a8845372741f98f627d99980158d9","instrument_name":"ES","fill_time":45293.680828310185,"commission":8.36,"price":4788.25,"is_buy":false,"quantity":4},
                                 {"id":1899,"account_name":"Sim101","order_id":"e9c1da6faa3d452ab348b06bd4a864f4","instrument_name":"ES","fill_time":45293.68089009259,"commission":2.09,"price":4788.25,"is_buy":true,"quantity":1},
                                 {"id":1900,"account_name":"Sim101","order_id":"e9c1da6faa3d452ab348b06bd4a864f4","instrument_name":"ES","fill_time":45293.680909513889,"commission":2.09,"price":4788.5,"is_buy":true,"quantity":1},
                                 {"id":1901,"account_name":"Sim101","order_id":"e9c1da6faa3d452ab348b06bd4a864f4","instrument_name":"ES","fill_time":45293.680910023148,"commission":2.09,"price":4788.25,"is_buy":true,"quantity":1},
                                 {"id":1902,"account_name":"Sim101","order_id":"482225b6be994185adcfac1922a0c013","instrument_name":"ES","fill_time":45293.681051944448,"commission":2.09,"price":4788,"is_buy":false,"quantity":1},
                                 {"id":1903,"account_name":"Sim101","order_id":"482225b6be994185adcfac1922a0c013","instrument_name":"ES","fill_time":45293.681054976849,"commission":2.09,"price":4788,"is_buy":false,"quantity":1},
                                 {"id":1904,"account_name":"Sim101","order_id":"482225b6be994185adcfac1922a0c013","instrument_name":"ES","fill_time":45293.68105550926,"commission":6.27,"price":4788,"is_buy":false,"quantity":3},
                                 {"id":1905,"account_name":"Sim101","order_id":"56ecb365e917499d840859158c15cc1a","instrument_name":"ES","fill_time":45293.681087974539,"commission":4.18,"price":4788,"is_buy":false,"quantity":2}
    ]);
    let response = app.post_ninja_trader_executions_import(&body).await;
    assert_eq!(401, response.status().as_u16());
}
