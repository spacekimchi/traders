with role_id as (
    select id from roles
    where name = 'super_admin'
)
insert into users (id, username, password_hash, email, role_id, ninja_trader_id)
values ('6982c6df-3d03-4583-8fa9-07386cf25f80', 'jhg', '$argon2id$v=19$m=15000,t=2,p=1$xjnT0gsfJCccXoCt8yD1HQ$rDkvWPpNR+yYNQ+U7+0U6RCLcgG/EnPPE3riQ615AFM', 'g@jinz.co', (select id from role_id), 'YourNinjaTraderIdString')
on conflict ("id") do nothing;
insert into instruments (code, price_per_tick)
values ('ES', 12.5)
