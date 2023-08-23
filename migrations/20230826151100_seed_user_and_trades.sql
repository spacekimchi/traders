with role_id as (
    select id from roles
    where name = 'super_admin'
)
insert into users (id, username, password_hash, email, role_id)
values ('6982c6df-3d03-4583-8fa9-07386cf25f80', 'jhg', '$argon2id$v=19$m=15000,t=2,p=1$xjnT0gsfJCccXoCt8yD1HQ$rDkvWPpNR+yYNQ+U7+0U6RCLcgG/EnPPE3riQ615AFM', 'g@jinz.co', (select id from role_id))
on conflict ("id") do nothing;

insert into accounts (user_id, name, sim)
values ('6982c6df-3d03-4583-8fa9-07386cf25f80', 'APEX-30411-08!Apex!Apex', false)
on conflict ("name") do nothing;

insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-08!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45140.2712047917, 45140.2712730324, 8.36, -200, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45140.2712047917, 4.18, 4567, 'false', 2),
((select id from t_id), (select id from i_id), 45140.2712730324, 4.18, 4569, 'true', 2);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-08!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45140.2713216667, 45140.2718856482, 8.36, 362.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45140.2713216667, 4.18, 4568.75, 'false', 2),
((select id from t_id), (select id from i_id), 45140.2718007755, 2.09, 4566, 'true', 1),
((select id from t_id), (select id from i_id), 45140.2718856482, 2.09, 4564.25, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-08!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45140.2828691782, 45140.2832716088, 4.18, 12.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45140.2828691782, 2.09, 4564.25, 'true', 1),
((select id from t_id), (select id from i_id), 45140.2832716088, 2.09, 4564.5, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-08!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45140.2875001389, 45140.2876815278, 4.18, -112.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45140.2875001389, 2.09, 4565.25, 'true', 1),
((select id from t_id), (select id from i_id), 45140.2876815278, 2.09, 4563, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-08!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45140.2881622107, 45140.2921892824, 16.72, 87.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45140.2881622107, 4.18, 4562.5, 'false', 2),
((select id from t_id), (select id from i_id), 45140.2893647222, 4.18, 4564.5, 'false', 2),
((select id from t_id), (select id from i_id), 45140.2920879282, 2.09, 4563, 'true', 1),
((select id from t_id), (select id from i_id), 45140.2920879398, 4.18, 4563, 'true', 2),
((select id from t_id), (select id from i_id), 45140.2921892824, 2.09, 4562.75, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-08!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45140.3112273958, 45140.3132078357, 4.18, 50, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45140.3112273958, 2.09, 4556, 'true', 1),
((select id from t_id), (select id from i_id), 45140.3132078357, 2.09, 4557, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-08!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45141.2720720949, 45141.2722978241, 4.18, 25, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45141.2720720949, 2.09, 4512.75, 'false', 1),
((select id from t_id), (select id from i_id), 45141.2722978241, 2.09, 4512.25, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-08!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45141.2741370023, 45141.2742846181, 4.18, 12.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45141.2741370023, 2.09, 4512, 'false', 1),
((select id from t_id), (select id from i_id), 45141.2742846181, 2.09, 4511.75, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-08!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45141.2749689236, 45141.2750686921, 4.18, 25, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45141.2749689236, 2.09, 4515.75, 'false', 1),
((select id from t_id), (select id from i_id), 45141.2750686921, 2.09, 4515.25, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-08!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45141.2779072338, 45141.2783308681, 4.18, 87.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45141.2779072338, 2.09, 4513.25, 'false', 1),
((select id from t_id), (select id from i_id), 45141.2783308681, 2.09, 4511.5, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-08!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45141.2957638657, 45141.2958951852, 4.18, 50, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45141.2957638657, 2.09, 4520.75, 'true', 1),
((select id from t_id), (select id from i_id), 45141.2958951852, 2.09, 4521.75, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-08!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45145.2765738079, 45145.2774779167, 4.18, -100, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45145.2765738079, 2.09, 4526.25, 'true', 1),
((select id from t_id), (select id from i_id), 45145.2774779167, 2.09, 4524.25, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-08!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45145.2776672338, 45145.2787053472, 8.36, -275, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45145.2776672338, 4.18, 4524, 'true', 2),
((select id from t_id), (select id from i_id), 45145.2787053009, 2.09, 4521.25, 'false', 1),
((select id from t_id), (select id from i_id), 45145.2787053472, 2.09, 4521.25, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-08!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45145.2789975, 45145.2869347569, 16.72, 550, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45145.2789975, 4.18, 4521.5, 'true', 2),
((select id from t_id), (select id from i_id), 45145.2807879977, 4.18, 4516, 'true', 2),
((select id from t_id), (select id from i_id), 45145.2868731019, 2.09, 4521.25, 'false', 1),
((select id from t_id), (select id from i_id), 45145.2868759606, 2.09, 4521.25, 'false', 1),
((select id from t_id), (select id from i_id), 45145.2868759722, 2.09, 4521.25, 'false', 1),
((select id from t_id), (select id from i_id), 45145.2869347569, 2.09, 4522.25, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-08!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45146.2974766319, 45146.2989689468, 4.18, -100, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45146.2974766319, 2.09, 4496, 'true', 1),
((select id from t_id), (select id from i_id), 45146.2989689468, 2.09, 4494, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-08!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45146.3006219329, 45146.300717419, 4.18, -100, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45146.3006219329, 2.09, 4491.5, 'false', 1),
((select id from t_id), (select id from i_id), 45146.300717419, 2.09, 4493.5, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-08!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45146.3007891088, 45146.3014662037, 8.36, 237.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45146.3007891088, 4.18, 4492.75, 'false', 2),
((select id from t_id), (select id from i_id), 45146.301306331, 2.09, 4490.75, 'true', 1),
((select id from t_id), (select id from i_id), 45146.3014662037, 2.09, 4490, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-08!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45146.3048488889, 45146.3063292593, 4.18, 50, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45146.3048488889, 2.09, 4487.25, 'false', 1),
((select id from t_id), (select id from i_id), 45146.3063292593, 2.09, 4486.25, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-08!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45146.4239847569, 45146.4254145602, 4.18, 50, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45146.4239847569, 2.09, 4496.5, 'true', 1),
((select id from t_id), (select id from i_id), 45146.4254145602, 2.09, 4497.5, 'false', 1);


insert into accounts (user_id, name, sim)
values ('6982c6df-3d03-4583-8fa9-07386cf25f80', 'APEX-30411-10!Apex!Apex', false)
on conflict ("name") do nothing;

insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-10!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45149.2533553704, 45149.2551261458, 0, 200, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45149.2533553704, 0, 4471.75, 'true', 2),
((select id from t_id), (select id from i_id), 45149.2551261458, 0, 4473.75, 'false', 2);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-10!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45149.2667459838, 45149.268609838, 0, -125, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45149.2667459838, 0, 4470.25, 'true', 1),
((select id from t_id), (select id from i_id), 45149.268609838, 0, 4467.75, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-10!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45149.2709304745, 45149.2716587616, 0, 100, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45149.2709304745, 0, 4465.5, 'false', 1),
((select id from t_id), (select id from i_id), 45149.2716587616, 0, 4463.5, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-10!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45149.282486088, 45149.2858437731, 12.54, 150, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45149.282486088, 2.09, 4462.75, 'false', 1),
((select id from t_id), (select id from i_id), 45149.2828219329, 2.09, 4464.5, 'false', 1),
((select id from t_id), (select id from i_id), 45149.2841944907, 2.09, 4466.25, 'false', 1),
((select id from t_id), (select id from i_id), 45149.2858437037, 2.09, 4463.5, 'true', 1),
((select id from t_id), (select id from i_id), 45149.2858437731, 4.18, 4463.5, 'true', 2);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-10!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45152.2746565394, 45152.2750099884, 8.36, -175, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45152.2746565394, 2.09, 4474.75, 'true', 1),
((select id from t_id), (select id from i_id), 45152.2749828009, 2.09, 4473.25, 'true', 1),
((select id from t_id), (select id from i_id), 45152.2750099884, 4.18, 4472.25, 'false', 2);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-10!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45152.2751891551, 45152.2757565856, 4.18, -100, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45152.2751891551, 2.09, 4472.25, 'true', 1),
((select id from t_id), (select id from i_id), 45152.2757565856, 2.09, 4470.25, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-10!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45152.2760235648, 45152.2800206019, 4.18, 262.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45152.2760235648, 2.09, 4471.5, 'true', 1),
((select id from t_id), (select id from i_id), 45152.2800206019, 2.09, 4476.75, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-10!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45152.2848836921, 45152.285210787, 4.18, -100, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45152.2848836921, 2.09, 4470.25, 'false', 1),
((select id from t_id), (select id from i_id), 45152.285210787, 2.09, 4472.25, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-10!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45152.2876257755, 45152.2885158565, 4.18, -100, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45152.2876257755, 2.09, 4475.75, 'true', 1),
((select id from t_id), (select id from i_id), 45152.2885158565, 2.09, 4473.75, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-10!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45152.2886700926, 45152.2903965046, 8.36, 150, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45152.2886700926, 2.09, 4474, 'true', 1),
((select id from t_id), (select id from i_id), 45152.2899776968, 2.09, 4475, 'true', 1),
((select id from t_id), (select id from i_id), 45152.2903959144, 2.09, 4476, 'false', 1),
((select id from t_id), (select id from i_id), 45152.2903965046, 2.09, 4476, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-10!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45152.3145656713, 45152.3151292245, 4.18, 50, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45152.3145656713, 2.09, 4486, 'true', 1),
((select id from t_id), (select id from i_id), 45152.3151292245, 2.09, 4487, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-10!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45152.3366284491, 45152.3375335069, 4.18, 62.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45152.3366284491, 2.09, 4495.5, 'false', 1),
((select id from t_id), (select id from i_id), 45152.3375335069, 2.09, 4494.25, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-10!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45152.536720787, 45152.5375173264, 4.18, 50, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45152.536720787, 2.09, 4497.5, 'true', 1),
((select id from t_id), (select id from i_id), 45152.5375173264, 2.09, 4498.5, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-10!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45153.2460461227, 45153.2476399884, 4.18, 50, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45153.2460461227, 2.09, 4475.75, 'true', 1),
((select id from t_id), (select id from i_id), 45153.2476399884, 2.09, 4476.75, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-10!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45153.2653580787, 45153.2709308912, 4.18, -125, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45153.2653580787, 2.09, 4486, 'false', 1),
((select id from t_id), (select id from i_id), 45153.2709308912, 2.09, 4488.5, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-10!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45153.2712760764, 45153.271555162, 4.18, -100, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45153.2712760764, 2.09, 4488.75, 'false', 1),
((select id from t_id), (select id from i_id), 45153.271555162, 2.09, 4490.75, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-10!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45153.2715988079, 45153.2735499306, 8.36, 187.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45153.2715988079, 2.09, 4489.5, 'false', 1),
((select id from t_id), (select id from i_id), 45153.2730950926, 2.09, 4490.25, 'false', 1),
((select id from t_id), (select id from i_id), 45153.2735499306, 4.18, 4488, 'true', 2);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-10!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45153.2765245949, 45153.2766767824, 4.18, 62.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45153.2765245949, 2.09, 4486.5, 'true', 1),
((select id from t_id), (select id from i_id), 45153.2766767824, 2.09, 4487.75, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-10!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45154.288733125, 45154.2892671875, 4.18, 12.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45154.288733125, 2.09, 4458.5, 'false', 1),
((select id from t_id), (select id from i_id), 45154.2892671875, 2.09, 4458.25, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-10!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45154.2908248264, 45154.2910752778, 4.18, 12.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45154.2908248264, 2.09, 4460, 'false', 1),
((select id from t_id), (select id from i_id), 45154.2910752778, 2.09, 4459.75, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-10!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45154.313064537, 45154.313173287, 4.18, 25, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45154.313064537, 2.09, 4458, 'true', 1),
((select id from t_id), (select id from i_id), 45154.313173287, 2.09, 4458.5, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-10!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45155.2599210417, 45155.2710275347, 4.18, 50, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45155.2599210417, 2.09, 4433, 'true', 1),
((select id from t_id), (select id from i_id), 45155.2710275347, 2.09, 4434, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-10!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45155.2826205787, 45155.2830533218, 4.18, 12.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45155.2826205787, 2.09, 4426, 'true', 1),
((select id from t_id), (select id from i_id), 45155.2830533218, 2.09, 4426.25, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-10!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45155.2886056134, 45155.2888528125, 4.18, 12.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45155.2886056134, 2.09, 4421, 'false', 1),
((select id from t_id), (select id from i_id), 45155.2888528125, 2.09, 4420.75, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-10!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45155.291363125, 45155.2922297801, 4.18, -100, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45155.291363125, 2.09, 4425, 'false', 1),
((select id from t_id), (select id from i_id), 45155.2922297801, 2.09, 4427, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-10!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45155.2928885995, 45155.2945129167, 8.36, 100, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45155.2928885995, 2.09, 4426.5, 'true', 1),
((select id from t_id), (select id from i_id), 45155.2938846412, 2.09, 4424.5, 'true', 1),
((select id from t_id), (select id from i_id), 45155.2945127546, 2.09, 4426.5, 'false', 1),
((select id from t_id), (select id from i_id), 45155.2945129167, 2.09, 4426.5, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-10!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45155.2991427894, 45155.2993442477, 4.18, -100, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45155.2991427894, 2.09, 4427, 'true', 1),
((select id from t_id), (select id from i_id), 45155.2993442477, 2.09, 4425, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-10!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45155.2995757639, 45155.3004129514, 4.18, -100, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45155.2995757639, 2.09, 4426.25, 'true', 1),
((select id from t_id), (select id from i_id), 45155.3004129514, 2.09, 4424.25, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-10!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45155.3006179051, 45155.3012307639, 8.36, -162.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45155.3006179051, 2.09, 4423.75, 'true', 1),
((select id from t_id), (select id from i_id), 45155.3011553472, 2.09, 4422, 'true', 1),
((select id from t_id), (select id from i_id), 45155.3012307639, 4.18, 4421.25, 'false', 2);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-10!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45155.301469919, 45155.3021577778, 8.36, -200, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45155.301469919, 2.09, 4421, 'false', 1),
((select id from t_id), (select id from i_id), 45155.3021457407, 2.09, 4424, 'false', 1),
((select id from t_id), (select id from i_id), 45155.3021574884, 2.09, 4424.5, 'true', 1),
((select id from t_id), (select id from i_id), 45155.3021577778, 2.09, 4424.5, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-10!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45155.3022182986, 45155.30275625, 8.36, 275, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45155.3022182986, 2.09, 4424, 'true', 1),
((select id from t_id), (select id from i_id), 45155.3023634491, 2.09, 4424, 'true', 1),
((select id from t_id), (select id from i_id), 45155.30275625, 4.18, 4426.75, 'false', 2);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-10!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45155.3225776157, 45155.3241663657, 4.18, 75, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45155.3225776157, 2.09, 4418.5, 'true', 1),
((select id from t_id), (select id from i_id), 45155.3241663657, 2.09, 4420, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-10!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45155.3245954167, 45155.3254399537, 4.18, -75, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45155.3245954167, 2.09, 4419.5, 'false', 1),
((select id from t_id), (select id from i_id), 45155.3254399537, 2.09, 4421, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-10!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45159.2723361343, 45159.2726943634, 4.18, 87.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45159.2723361343, 2.09, 4394.25, 'true', 1),
((select id from t_id), (select id from i_id), 45159.2726943634, 2.09, 4396, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-10!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45160.2469814815, 45160.2497848495, 4.18, 50, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45160.2469814815, 2.09, 4432.25, 'false', 1),
((select id from t_id), (select id from i_id), 45160.2497848495, 2.09, 4431.25, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-10!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45160.2756916667, 45160.2763206134, 4.18, 62.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45160.2756916667, 2.09, 4426.25, 'false', 1),
((select id from t_id), (select id from i_id), 45160.2763206134, 2.09, 4425, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-10!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45160.2816376968, 45160.2820399884, 4.18, 50, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45160.2816376968, 2.09, 4423, 'false', 1),
((select id from t_id), (select id from i_id), 45160.2820399884, 2.09, 4422, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-10!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45160.3094652546, 45160.3100010185, 4.18, -100, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45160.3094652546, 2.09, 4416.5, 'true', 1),
((select id from t_id), (select id from i_id), 45160.3100010185, 2.09, 4414.5, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-10!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45160.3254989005, 45160.3280096065, 4.18, -62.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45160.3254989005, 2.09, 4411.25, 'false', 1),
((select id from t_id), (select id from i_id), 45160.3280096065, 2.09, 4412.5, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-10!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45160.3376707292, 45160.338025162, 4.18, 62.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45160.3376707292, 2.09, 4411.25, 'true', 1),
((select id from t_id), (select id from i_id), 45160.338025162, 2.09, 4412.5, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-10!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45161.2423339931, 45161.2465384838, 4.18, 137.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45161.2423339931, 2.09, 4405, 'false', 1),
((select id from t_id), (select id from i_id), 45161.2465384838, 2.09, 4402.25, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-10!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45162.2400791435, 45162.2407016667, 4.18, 112.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45162.2400791435, 2.09, 4465, 'true', 1),
((select id from t_id), (select id from i_id), 45162.2407016667, 2.09, 4467.25, 'false', 1);


insert into accounts (user_id, name, sim)
values ('6982c6df-3d03-4583-8fa9-07386cf25f80', 'APEX-30411-05!Apex!Apex', false)
on conflict ("name") do nothing;

insert into instruments (code, price_per_point)
values ('NQ', 20)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'NQ'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45033.3009395602, 45033.3009501157, 4.18, -45, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45033.3009395602, 2.09, 13159.75, 'false', 1),
((select id from t_id), (select id from i_id), 45033.3009501157, 2.09, 13162, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 44973.2951853935, 44973.2952691088, 4.08, -112.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 44973.2951853935, 2.04, 4103.75, 'false', 1),
((select id from t_id), (select id from i_id), 44973.2952691088, 2.04, 4106, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 44973.3092585995, 44973.3105667477, 4.08, -137.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 44973.3092585995, 2.04, 4119.75, 'true', 1),
((select id from t_id), (select id from i_id), 44973.3105667477, 2.04, 4117, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 44973.311010544, 44973.3178340741, 4.08, 350, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 44973.311010544, 2.04, 4118, 'true', 1),
((select id from t_id), (select id from i_id), 44973.3178340741, 2.04, 4125, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 44973.331424838, 44973.3318765509, 4.08, -125, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 44973.331424838, 2.04, 4128.25, 'true', 1),
((select id from t_id), (select id from i_id), 44973.3318765509, 2.04, 4125.75, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 44973.3329447338, 44973.3371534606, 4.08, 125, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 44973.3329447338, 2.04, 4129, 'true', 1),
((select id from t_id), (select id from i_id), 44973.3371534606, 2.04, 4131.5, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 44973.3527923032, 44973.3533893403, 4.08, -100, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 44973.3527923032, 2.04, 4126.25, 'false', 1),
((select id from t_id), (select id from i_id), 44973.3533893403, 2.04, 4128.25, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45008.3541504282, 45008.3542041551, 4.18, 87.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45008.3541504282, 2.09, 4025.75, 'true', 1),
((select id from t_id), (select id from i_id), 45008.3542041551, 2.09, 4027.5, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45008.5003256482, 45008.5003441088, 4.18, 100, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45008.5003256482, 2.09, 3980.25, 'true', 1),
((select id from t_id), (select id from i_id), 45008.5003441088, 2.09, 3982.25, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45008.5075582523, 45008.5077606944, 4.18, 75, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45008.5075582523, 2.09, 3977.25, 'true', 1),
((select id from t_id), (select id from i_id), 45008.5077606944, 2.09, 3978.75, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45012.3407961574, 45012.3413507523, 4.18, 37.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45012.3407961574, 2.09, 4004.5, 'true', 1),
((select id from t_id), (select id from i_id), 45012.3413507523, 2.09, 4005.25, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45012.3424664468, 45012.3452993866, 4.18, 100, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45012.3424664468, 2.09, 4008, 'false', 1),
((select id from t_id), (select id from i_id), 45012.3452993866, 2.09, 4006, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45012.3511648843, 45012.3516677662, 4.18, 12.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45012.3511648843, 2.09, 4008.75, 'false', 1),
((select id from t_id), (select id from i_id), 45012.3516677662, 2.09, 4008.5, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45012.3541087269, 45012.3545353241, 4.18, -100, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45012.3541087269, 2.09, 4010.5, 'false', 1),
((select id from t_id), (select id from i_id), 45012.3545353241, 2.09, 4012.5, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45012.3556752431, 45012.3569735185, 8.36, 100, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45012.3556752431, 2.09, 4011.5, 'false', 1),
((select id from t_id), (select id from i_id), 45012.3563752199, 2.09, 4013, 'false', 1),
((select id from t_id), (select id from i_id), 45012.3569735069, 2.09, 4011.25, 'true', 1),
((select id from t_id), (select id from i_id), 45012.3569735185, 2.09, 4011.25, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45012.4813380671, 45012.4827986458, 4.18, -37.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45012.4813380671, 2.09, 4021.5, 'true', 1),
((select id from t_id), (select id from i_id), 45012.4827986458, 2.09, 4020.75, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45012.4827993981, 45012.4829319676, 4.18, -37.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45012.4827993981, 2.09, 4020.75, 'false', 1),
((select id from t_id), (select id from i_id), 45012.4829319676, 2.09, 4021.5, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45014.2961031713, 45014.2973710185, 4.18, 37.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45014.2961031713, 2.09, 4043.25, 'true', 1),
((select id from t_id), (select id from i_id), 45014.2973710185, 2.09, 4044, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45014.3127031597, 45014.3132779745, 4.18, 50, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45014.3127031597, 2.09, 4040.5, 'false', 1),
((select id from t_id), (select id from i_id), 45014.3132779745, 2.09, 4039.5, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45014.316833206, 45014.3224103125, 12.54, 162.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45014.316833206, 2.09, 4038, 'true', 1),
((select id from t_id), (select id from i_id), 45014.3181432176, 2.09, 4036, 'true', 1),
((select id from t_id), (select id from i_id), 45014.3197913542, 2.09, 4035.25, 'true', 1),
((select id from t_id), (select id from i_id), 45014.3224103125, 6.27, 4037.5, 'false', 3);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45015.3041430208, 45015.3048272338, 8.36, 37.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45015.3041430208, 2.09, 4073.5, 'true', 1),
((select id from t_id), (select id from i_id), 45015.3045754514, 2.09, 4072.75, 'true', 1),
((select id from t_id), (select id from i_id), 45015.3048272338, 4.18, 4073.5, 'false', 2);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45015.4323460764, 45015.4324651736, 4.18, 37.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45015.4323460764, 2.09, 4069.5, 'true', 1),
((select id from t_id), (select id from i_id), 45015.4324651736, 2.09, 4070.25, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45015.4569449306, 45015.4658434954, 16.72, 62.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45015.4569449306, 2.09, 4065, 'false', 1),
((select id from t_id), (select id from i_id), 45015.4594679167, 2.09, 4068.25, 'false', 1),
((select id from t_id), (select id from i_id), 45015.4623189815, 4.18, 4069.5, 'false', 2),
((select id from t_id), (select id from i_id), 45015.4658434838, 2.09, 4067.75, 'true', 1),
((select id from t_id), (select id from i_id), 45015.4658434954, 6.27, 4067.75, 'true', 3);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45016.2847937963, 45016.284854213, 4.18, 37.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45016.2847937963, 2.09, 4100.25, 'true', 1),
((select id from t_id), (select id from i_id), 45016.284854213, 2.09, 4101, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45016.2985446875, 45016.2990822338, 4.18, 25, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45016.2985446875, 2.09, 4099.5, 'true', 1),
((select id from t_id), (select id from i_id), 45016.2990822338, 2.09, 4100, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45019.2782535069, 45019.2789841088, 4.18, -37.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45019.2782535069, 2.09, 4141.75, 'true', 1),
((select id from t_id), (select id from i_id), 45019.2789841088, 2.09, 4141, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45019.2798833565, 45019.2799657523, 4.18, 25, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45019.2798833565, 2.09, 4140.25, 'true', 1),
((select id from t_id), (select id from i_id), 45019.2799657523, 2.09, 4140.75, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45019.2801303704, 45019.2824655556, 4.18, -100, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45019.2801303704, 2.09, 4140.25, 'false', 1),
((select id from t_id), (select id from i_id), 45019.2824655556, 2.09, 4142.25, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45019.2826903704, 45019.2846953356, 4.18, 200, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45019.2826903704, 2.09, 4143.75, 'true', 1),
((select id from t_id), (select id from i_id), 45019.2846953356, 2.09, 4147.75, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45019.2869137268, 45019.2871094213, 4.18, 12.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45019.2869137268, 2.09, 4149.5, 'true', 1),
((select id from t_id), (select id from i_id), 45019.2871094213, 2.09, 4149.75, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45019.2916595833, 45019.2916771412, 4.18, 100, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45019.2916595833, 2.09, 4144.75, 'true', 1),
((select id from t_id), (select id from i_id), 45019.2916771412, 2.09, 4146.75, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45019.2919129861, 45019.2921692593, 4.18, 12.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45019.2919129861, 2.09, 4147, 'true', 1),
((select id from t_id), (select id from i_id), 45019.2921692593, 2.09, 4147.25, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45019.2945861111, 45019.2980409954, 12.54, 75, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45019.2945861111, 2.09, 4149.75, 'true', 1),
((select id from t_id), (select id from i_id), 45019.2948005787, 2.09, 4149.25, 'true', 1),
((select id from t_id), (select id from i_id), 45019.2961228009, 2.09, 4145.75, 'true', 1),
((select id from t_id), (select id from i_id), 45019.2980409954, 6.27, 4148.75, 'false', 3);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45019.3040350463, 45019.3048522569, 4.18, 50, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45019.3040350463, 2.09, 4151, 'true', 1),
((select id from t_id), (select id from i_id), 45019.3048522569, 2.09, 4152, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45020.2709768982, 45020.2755224884, 12.54, 100, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45020.2709768982, 2.09, 4160.75, 'true', 1),
((select id from t_id), (select id from i_id), 45020.2715076389, 2.09, 4159, 'true', 1),
((select id from t_id), (select id from i_id), 45020.2731685764, 2.09, 4156.25, 'true', 1),
((select id from t_id), (select id from i_id), 45020.2754950463, 2.09, 4159.5, 'false', 1),
((select id from t_id), (select id from i_id), 45020.2755224884, 4.18, 4159.25, 'false', 2);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45020.2784016319, 45020.2851335301, 8.36, 50, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45020.2784016319, 2.09, 4152.75, 'false', 1),
((select id from t_id), (select id from i_id), 45020.2848565046, 2.09, 4153.25, 'false', 1),
((select id from t_id), (select id from i_id), 45020.2851335069, 2.09, 4152.5, 'true', 1),
((select id from t_id), (select id from i_id), 45020.2851335301, 2.09, 4152.5, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45021.2761966667, 45021.2773599884, 4.18, 50, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45021.2761966667, 2.09, 4121, 'false', 1),
((select id from t_id), (select id from i_id), 45021.2773599884, 2.09, 4120, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45021.2778850347, 45021.2787920949, 4.18, 50, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45021.2778850347, 2.09, 4120, 'true', 1),
((select id from t_id), (select id from i_id), 45021.2787920949, 2.09, 4121, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45021.279984838, 45021.2810015625, 4.18, 25, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45021.279984838, 2.09, 4122.25, 'false', 1),
((select id from t_id), (select id from i_id), 45021.2810015625, 2.09, 4121.75, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45021.2823405787, 45021.2833555787, 4.18, 50, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45021.2823405787, 2.09, 4122.5, 'true', 1),
((select id from t_id), (select id from i_id), 45021.2833555787, 2.09, 4123.5, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45021.2855648032, 45021.2858819097, 4.18, 50, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45021.2855648032, 2.09, 4122.75, 'false', 1),
((select id from t_id), (select id from i_id), 45021.2858819097, 2.09, 4121.75, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45021.2892647569, 45021.2894164236, 4.18, 25, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45021.2892647569, 2.09, 4124.75, 'true', 1),
((select id from t_id), (select id from i_id), 45021.2894164236, 2.09, 4125.25, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45022.2970512037, 45022.2971251736, 4.18, 37.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45022.2970512037, 2.09, 4106, 'true', 1),
((select id from t_id), (select id from i_id), 45022.2971251736, 2.09, 4106.75, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45022.3018953704, 45022.302758206, 4.18, -125, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45022.3018953704, 2.09, 4112.25, 'true', 1),
((select id from t_id), (select id from i_id), 45022.302758206, 2.09, 4109.75, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45022.3028400579, 45022.3059337731, 4.18, -100, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45022.3028400579, 2.09, 4110.75, 'true', 1),
((select id from t_id), (select id from i_id), 45022.3059337731, 2.09, 4108.75, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45022.306187662, 45022.3123476852, 8.36, 100, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45022.306187662, 4.18, 4108.5, 'false', 2),
((select id from t_id), (select id from i_id), 45022.3123476852, 4.18, 4107.5, 'true', 2);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45022.3151415046, 45022.3171270602, 8.36, 50, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45022.3151415046, 2.09, 4109.25, 'false', 1),
((select id from t_id), (select id from i_id), 45022.315527037, 2.09, 4110.75, 'false', 1),
((select id from t_id), (select id from i_id), 45022.3171270602, 4.18, 4109.5, 'true', 2);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45022.317329919, 45022.3210287847, 16.72, -725, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45022.317329919, 2.09, 4109.25, 'true', 1),
((select id from t_id), (select id from i_id), 45022.3174995023, 2.09, 4106.75, 'true', 1),
((select id from t_id), (select id from i_id), 45022.3192320139, 4.18, 4106.25, 'true', 2),
((select id from t_id), (select id from i_id), 45022.3210287847, 8.36, 4103.5, 'false', 4);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45022.3212304745, 45022.3216269213, 16.72, 300, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45022.3212304745, 8.36, 4104.25, 'false', 4),
((select id from t_id), (select id from i_id), 45022.3216269213, 8.36, 4102.75, 'true', 4);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45022.3221303935, 45022.3224526968, 16.72, 150, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45022.3221303935, 8.36, 4101.75, 'true', 4),
((select id from t_id), (select id from i_id), 45022.3224526968, 8.36, 4102.5, 'false', 4);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45022.3232023611, 45022.323695, 12.54, -300, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45022.3232023611, 6.27, 4103.25, 'false', 3),
((select id from t_id), (select id from i_id), 45022.3236949884, 2.09, 4105.25, 'true', 1),
((select id from t_id), (select id from i_id), 45022.323695, 4.18, 4105.25, 'true', 2);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45022.3238361227, 45022.3265789699, 37.620000000000005, 337.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45022.3238361227, 6.27, 4104.75, 'false', 3),
((select id from t_id), (select id from i_id), 45022.3239326042, 6.27, 4105.25, 'false', 3),
((select id from t_id), (select id from i_id), 45022.324435706, 2.09, 4106.5, 'false', 1),
((select id from t_id), (select id from i_id), 45022.3244405787, 4.18, 4106.5, 'false', 2),
((select id from t_id), (select id from i_id), 45022.3265789583, 16.72, 4104.75, 'true', 8),
((select id from t_id), (select id from i_id), 45022.3265789699, 2.09, 4104.75, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45022.3273405671, 45022.3288663426, 12.54, 37.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45022.3273405671, 6.27, 4104.75, 'true', 3),
((select id from t_id), (select id from i_id), 45022.3288663194, 2.09, 4105, 'false', 1),
((select id from t_id), (select id from i_id), 45022.3288663426, 4.18, 4105, 'false', 2);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45026.2748109028, 45026.2755220255, 4.18, -100, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45026.2748109028, 2.09, 4100.75, 'true', 1),
((select id from t_id), (select id from i_id), 45026.2755220255, 2.09, 4098.75, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45026.2757620486, 45026.2780127199, 8.36, -250, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45026.2757620486, 2.09, 4100, 'false', 1),
((select id from t_id), (select id from i_id), 45026.277448912, 2.09, 4102.5, 'false', 1),
((select id from t_id), (select id from i_id), 45026.2780127083, 2.09, 4103.75, 'true', 1),
((select id from t_id), (select id from i_id), 45026.2780127199, 2.09, 4103.75, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45026.278301088, 45026.2785671759, 4.18, -100, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45026.278301088, 2.09, 4102, 'false', 1),
((select id from t_id), (select id from i_id), 45026.2785671759, 2.09, 4104, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45027.2987623032, 45027.2992609722, 4.18, 75, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45027.2987623032, 2.09, 4138.5, 'false', 1),
((select id from t_id), (select id from i_id), 45027.2992609722, 2.09, 4137, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45028.2934278935, 45028.2934964236, 4.18, 50, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45028.2934278935, 2.09, 4148.75, 'true', 1),
((select id from t_id), (select id from i_id), 45028.2934964236, 2.09, 4149.75, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45028.2944295833, 45028.2952189583, 4.18, 12.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45028.2944295833, 2.09, 4150.5, 'false', 1),
((select id from t_id), (select id from i_id), 45028.2952189583, 2.09, 4150.25, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45028.2975680556, 45028.2990360185, 4.18, 50, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45028.2975680556, 2.09, 4153.25, 'true', 1),
((select id from t_id), (select id from i_id), 45028.2990360185, 2.09, 4154.25, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45028.3042675, 45028.3063900579, 4.18, 100, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45028.3042675, 2.09, 4154, 'true', 1),
((select id from t_id), (select id from i_id), 45028.3063900579, 2.09, 4156, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45029.2900894329, 45029.2902840625, 4.18, 100, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45029.2900894329, 2.09, 4129.75, 'false', 1),
((select id from t_id), (select id from i_id), 45029.2902840625, 2.09, 4127.75, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45029.2917466204, 45029.2956210069, 4.18, -237.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45029.2917466204, 2.09, 4129, 'false', 1),
((select id from t_id), (select id from i_id), 45029.2956210069, 2.09, 4133.75, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45030.3506276505, 45030.3536557176, 4.18, 100, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45030.3506276505, 2.09, 4156.5, 'false', 1),
((select id from t_id), (select id from i_id), 45030.3536557176, 2.09, 4154.5, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45030.3554525694, 45030.3561770602, 8.36, -225, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45030.3554525694, 4.18, 4154.5, 'true', 2),
((select id from t_id), (select id from i_id), 45030.3561770602, 4.18, 4152.25, 'false', 2);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45030.3563185648, 45030.3569805787, 4.18, -137.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45030.3563185648, 2.09, 4152.5, 'false', 1),
((select id from t_id), (select id from i_id), 45030.3569805787, 2.09, 4155.25, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45030.3572310185, 45030.3610675347, 33.44, -900, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45030.3572310185, 8.36, 4155.75, 'true', 4),
((select id from t_id), (select id from i_id), 45030.3594528009, 8.36, 4153.25, 'true', 4),
((select id from t_id), (select id from i_id), 45030.3610675347, 16.72, 4152.25, 'false', 8);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45030.3611632755, 45030.3617652778, 41.8, -612.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45030.3611632755, 4.18, 4152.25, 'false', 2),
((select id from t_id), (select id from i_id), 45030.361163287, 2.09, 4152.25, 'false', 1),
((select id from t_id), (select id from i_id), 45030.3611689815, 6.27, 4152.5, 'false', 3),
((select id from t_id), (select id from i_id), 45030.3617002315, 8.36, 4152.75, 'false', 4),
((select id from t_id), (select id from i_id), 45030.3617652778, 20.9, 4153.75, 'true', 10);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45033.3047251736, 45033.3066759722, 4.18, 37.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45033.3047251736, 2.09, 4166.25, 'true', 1),
((select id from t_id), (select id from i_id), 45033.3066759722, 2.09, 4167, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45033.3119382755, 45033.3133684722, 8.36, 62.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45033.3119382755, 2.09, 4167, 'true', 1),
((select id from t_id), (select id from i_id), 45033.3123846181, 2.09, 4165.75, 'true', 1),
((select id from t_id), (select id from i_id), 45033.3133677662, 2.09, 4167, 'false', 1),
((select id from t_id), (select id from i_id), 45033.3133684722, 2.09, 4167, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45036.3178562037, 45036.3190088426, 4.18, -175, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45036.3178562037, 2.09, 4159.75, 'true', 1),
((select id from t_id), (select id from i_id), 45036.3190088426, 2.09, 4156.25, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45037.3641125347, 45037.3676431944, 8.36, -387.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45037.3641125347, 2.09, 4150.5, 'true', 1),
((select id from t_id), (select id from i_id), 45037.3663731134, 2.09, 4146.75, 'true', 1),
((select id from t_id), (select id from i_id), 45037.3676431944, 4.18, 4144.75, 'false', 2);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45040.2964959491, 45040.3005913773, 4.18, -137.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45040.2964959491, 2.09, 4157.75, 'false', 1),
((select id from t_id), (select id from i_id), 45040.3005913773, 2.09, 4160.5, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45040.3018453125, 45040.302427581, 4.18, -100, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45040.3018453125, 2.09, 4162.25, 'true', 1),
((select id from t_id), (select id from i_id), 45040.302427581, 2.09, 4160.25, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45040.3027849884, 45040.3135947685, 4.18, 100, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45040.3027849884, 2.09, 4160, 'true', 1),
((select id from t_id), (select id from i_id), 45040.3135947685, 2.09, 4162, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45040.327546331, 45040.3319416088, 4.18, 25, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45040.327546331, 2.09, 4151, 'false', 1),
((select id from t_id), (select id from i_id), 45040.3319416088, 2.09, 4150.5, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45040.3520529745, 45040.353154213, 4.18, 50, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45040.3520529745, 2.09, 4146.75, 'false', 1),
((select id from t_id), (select id from i_id), 45040.353154213, 2.09, 4145.75, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45041.3271515393, 45041.3288303472, 4.18, 50, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45041.3271515393, 2.09, 4131.5, 'false', 1),
((select id from t_id), (select id from i_id), 45041.3288303472, 2.09, 4130.5, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45041.3383465972, 45041.3406240741, 8.36, -237.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45041.3383465972, 2.09, 4129.5, 'false', 1),
((select id from t_id), (select id from i_id), 45041.3401031713, 2.09, 4131.75, 'false', 1),
((select id from t_id), (select id from i_id), 45041.3406240741, 4.18, 4133, 'true', 2);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45041.3419815625, 45041.347989537, 4.18, 12.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45041.3419815625, 2.09, 4133.75, 'true', 1),
((select id from t_id), (select id from i_id), 45041.347989537, 2.09, 4134, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45041.3489, 45041.3535622801, 4.18, -100, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45041.3489, 2.09, 4130.5, 'true', 1),
((select id from t_id), (select id from i_id), 45041.3535622801, 2.09, 4128.5, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45041.3582763889, 45041.3605802083, 4.18, -100, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45041.3582763889, 2.09, 4125.25, 'true', 1),
((select id from t_id), (select id from i_id), 45041.3605802083, 2.09, 4123.25, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45047.2928768171, 45047.2931112731, 4.18, 100, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45047.2928768171, 2.09, 4190, 'true', 1),
((select id from t_id), (select id from i_id), 45047.2931112731, 2.09, 4192, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45048.2996655324, 45048.2998990509, 4.18, 50, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45048.2996655324, 2.09, 4150.75, 'false', 1),
((select id from t_id), (select id from i_id), 45048.2998990509, 2.09, 4149.75, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45048.3041610764, 45048.3047629398, 4.18, 50, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45048.3041610764, 2.09, 4150, 'false', 1),
((select id from t_id), (select id from i_id), 45048.3047629398, 2.09, 4149, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45048.3318937037, 45048.3323636227, 4.18, 25, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45048.3318937037, 2.09, 4120.25, 'false', 1),
((select id from t_id), (select id from i_id), 45048.3323636227, 2.09, 4119.75, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45049.2947238542, 45049.2960648958, 4.18, -100, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45049.2947238542, 2.09, 4148.75, 'true', 1),
((select id from t_id), (select id from i_id), 45049.2960648958, 2.09, 4146.75, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45049.2972322917, 45049.2998455208, 4.18, -100, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45049.2972322917, 2.09, 4148.5, 'true', 1),
((select id from t_id), (select id from i_id), 45049.2998455208, 2.09, 4146.5, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45049.3010854051, 45049.3015926042, 4.18, -100, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45049.3010854051, 2.09, 4143.75, 'true', 1),
((select id from t_id), (select id from i_id), 45049.3015926042, 2.09, 4141.75, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45049.3030601157, 45049.3118228704, 4.18, -100, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45049.3030601157, 2.09, 4144.5, 'true', 1),
((select id from t_id), (select id from i_id), 45049.3118228704, 2.09, 4142.5, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45050.2584989931, 45050.2592214583, 4.18, 150, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45050.2584989931, 2.09, 4097, 'false', 1),
((select id from t_id), (select id from i_id), 45050.2592214583, 2.09, 4094, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45050.2806549884, 45050.2808959144, 4.18, 50, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45050.2806549884, 2.09, 4078.75, 'false', 1),
((select id from t_id), (select id from i_id), 45050.2808959144, 2.09, 4077.75, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45050.294431412, 45050.2945120023, 4.18, 50, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45050.294431412, 2.09, 4082.25, 'false', 1),
((select id from t_id), (select id from i_id), 45050.2945120023, 2.09, 4081.25, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45054.2734837963, 45054.2737645486, 4.18, 25, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45054.2734837963, 2.09, 4150, 'false', 1),
((select id from t_id), (select id from i_id), 45054.2737645486, 2.09, 4149.5, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45054.2752330671, 45054.2775296991, 8.36, 62.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45054.2752330671, 2.09, 4152.5, 'false', 1),
((select id from t_id), (select id from i_id), 45054.2763034028, 2.09, 4153.75, 'false', 1),
((select id from t_id), (select id from i_id), 45054.2775296875, 2.09, 4152.5, 'true', 1),
((select id from t_id), (select id from i_id), 45054.2775296991, 2.09, 4152.5, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45054.2820844213, 45054.2821475463, 4.18, 37.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45054.2820844213, 2.09, 4149.25, 'false', 1),
((select id from t_id), (select id from i_id), 45054.2821475463, 2.09, 4148.5, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45054.2940979282, 45054.2943874306, 4.18, 50, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45054.2940979282, 2.09, 4147.75, 'true', 1),
((select id from t_id), (select id from i_id), 45054.2943874306, 2.09, 4148.75, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45054.3060245833, 45054.3062620602, 4.18, 25, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45054.3060245833, 2.09, 4146.5, 'false', 1),
((select id from t_id), (select id from i_id), 45054.3062620602, 2.09, 4146, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45054.314728669, 45054.3149305903, 4.18, 12.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45054.314728669, 2.09, 4145, 'false', 1),
((select id from t_id), (select id from i_id), 45054.3149305903, 2.09, 4144.75, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45054.3223349074, 45054.3224718403, 4.18, 25, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45054.3223349074, 2.09, 4146.5, 'false', 1),
((select id from t_id), (select id from i_id), 45054.3224718403, 2.09, 4146, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45055.2841350463, 45055.2855428588, 4.18, 12.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45055.2841350463, 2.09, 4135.75, 'true', 1),
((select id from t_id), (select id from i_id), 45055.2855428588, 2.09, 4136, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45055.2965037269, 45055.2969367361, 4.18, -100, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45055.2965037269, 2.09, 4137.5, 'true', 1),
((select id from t_id), (select id from i_id), 45055.2969367361, 2.09, 4135.5, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45055.2986621528, 45055.3002503472, 4.18, -100, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45055.2986621528, 2.09, 4135, 'true', 1),
((select id from t_id), (select id from i_id), 45055.3002503472, 2.09, 4133, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45055.3006859722, 45055.3020020949, 4.18, -62.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45055.3006859722, 2.09, 4134.75, 'true', 1),
((select id from t_id), (select id from i_id), 45055.3020020949, 2.09, 4133.5, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45056.2691185764, 45056.2717234954, 4.18, 100, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45056.2691185764, 2.09, 4163.75, 'true', 1),
((select id from t_id), (select id from i_id), 45056.2717234954, 2.09, 4165.75, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45056.2854884954, 45056.2857716088, 4.18, 25, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45056.2854884954, 2.09, 4140, 'false', 1),
((select id from t_id), (select id from i_id), 45056.2857716088, 2.09, 4139.5, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45056.2873066435, 45056.2881425347, 4.18, 25, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45056.2873066435, 2.09, 4139.75, 'false', 1),
((select id from t_id), (select id from i_id), 45056.2881425347, 2.09, 4139.25, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45056.2913256481, 45056.2914417245, 4.18, 62.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45056.2913256481, 2.09, 4147.25, 'true', 1),
((select id from t_id), (select id from i_id), 45056.2914417245, 2.09, 4148.5, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45056.2935173611, 45056.2936259607, 4.18, 62.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45056.2935173611, 2.09, 4155.75, 'true', 1),
((select id from t_id), (select id from i_id), 45056.2936259607, 2.09, 4157, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45056.2947504398, 45056.2951271991, 4.18, 0, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45056.2947504398, 2.09, 4157.5, 'true', 1),
((select id from t_id), (select id from i_id), 45056.2951271991, 2.09, 4157.5, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45056.2983066319, 45056.2984127778, 4.18, -200, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45056.2983066319, 2.09, 4158.5, 'true', 1),
((select id from t_id), (select id from i_id), 45056.2984127778, 2.09, 4154.5, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45056.2985235069, 45056.2996042361, 8.36, 162.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45056.2985235069, 2.09, 4156.25, 'true', 1),
((select id from t_id), (select id from i_id), 45056.2990304977, 2.09, 4155, 'true', 1),
((select id from t_id), (select id from i_id), 45056.2996041898, 2.09, 4157.25, 'false', 1),
((select id from t_id), (select id from i_id), 45056.2996042361, 2.09, 4157.25, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45056.305786956, 45056.305882419, 4.18, 50, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45056.305786956, 2.09, 4144.25, 'true', 1),
((select id from t_id), (select id from i_id), 45056.305882419, 2.09, 4145.25, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45057.333889838, 45057.3340444329, 4.18, 50, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45057.333889838, 2.09, 4136.5, 'true', 1),
((select id from t_id), (select id from i_id), 45057.3340444329, 2.09, 4137.5, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45058.2718069907, 45058.2719687269, 4.18, 37.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45058.2718069907, 2.09, 4156.25, 'false', 1),
((select id from t_id), (select id from i_id), 45058.2719687269, 2.09, 4155.5, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45058.2750265972, 45058.275230463, 4.18, 50, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45058.2750265972, 2.09, 4155.25, 'false', 1),
((select id from t_id), (select id from i_id), 45058.275230463, 2.09, 4154.25, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45058.2781934954, 45058.2808414468, 25.08, 262.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45058.2781934954, 2.09, 4154.5, 'false', 1),
((select id from t_id), (select id from i_id), 45058.2788246528, 2.09, 4156.25, 'false', 1),
((select id from t_id), (select id from i_id), 45058.2802954745, 2.09, 4157.25, 'false', 1),
((select id from t_id), (select id from i_id), 45058.2802955208, 6.27, 4157.25, 'false', 3),
((select id from t_id), (select id from i_id), 45058.2808414352, 2.09, 4155.75, 'true', 1),
((select id from t_id), (select id from i_id), 45058.2808414468, 10.45, 4155.75, 'true', 5);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45058.2856697222, 45058.2864847569, 4.18, -100, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45058.2856697222, 2.09, 4152.25, 'false', 1),
((select id from t_id), (select id from i_id), 45058.2864847569, 2.09, 4154.25, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45058.2867785185, 45058.2897173148, 4.18, 50, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45058.2867785185, 2.09, 4153.25, 'false', 1),
((select id from t_id), (select id from i_id), 45058.2897173148, 2.09, 4152.25, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45058.2930173148, 45058.2942335301, 25.08, 325, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45058.2930173148, 4.18, 4143.75, 'false', 2),
((select id from t_id), (select id from i_id), 45058.2938840046, 6.27, 4147.25, 'false', 3),
((select id from t_id), (select id from i_id), 45058.2938843866, 2.09, 4147.25, 'false', 1),
((select id from t_id), (select id from i_id), 45058.2942335301, 12.54, 4145, 'true', 6);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45093.2704943982, 45093.2706358333, 8.36, 262.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45093.2704943982, 4.18, 4487.5, 'true', 2),
((select id from t_id), (select id from i_id), 45093.270546956, 2.09, 4489.5, 'false', 1),
((select id from t_id), (select id from i_id), 45093.2706358333, 2.09, 4490.75, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45097.2731995833, 45097.2737398611, 8.36, -200, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45097.2731995833, 4.18, 4439, 'false', 2),
((select id from t_id), (select id from i_id), 45097.2737398611, 4.18, 4441, 'true', 2);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45097.2738432176, 45097.2764488773, 25.08, 350, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45097.2738432176, 4.18, 4440.5, 'false', 2),
((select id from t_id), (select id from i_id), 45097.2756692824, 8.36, 4442.25, 'false', 4),
((select id from t_id), (select id from i_id), 45097.2763480324, 2.09, 4440.5, 'true', 1),
((select id from t_id), (select id from i_id), 45097.276348044, 2.09, 4440.5, 'true', 1),
((select id from t_id), (select id from i_id), 45097.2763480556, 4.18, 4440.5, 'true', 2),
((select id from t_id), (select id from i_id), 45097.2763480787, 2.09, 4440.5, 'true', 1),
((select id from t_id), (select id from i_id), 45097.2764488773, 2.09, 4440.5, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45098.3880569907, 45098.3907869792, 25.08, 225, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45098.3880569907, 4.18, 4420.75, 'true', 2),
((select id from t_id), (select id from i_id), 45098.389636331, 8.36, 4417.5, 'true', 4),
((select id from t_id), (select id from i_id), 45098.3905644444, 10.45, 4419.5, 'false', 5),
((select id from t_id), (select id from i_id), 45098.3907869792, 2.09, 4419.75, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45099.2717149769, 45099.2724703009, 8.36, -200, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45099.2717149769, 4.18, 4397, 'true', 2),
((select id from t_id), (select id from i_id), 45099.2724700347, 2.09, 4395, 'false', 1),
((select id from t_id), (select id from i_id), 45099.2724703009, 2.09, 4395, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45099.2727283681, 45099.274884838, 25.08, 600, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45099.2727283681, 4.18, 4396, 'true', 2),
((select id from t_id), (select id from i_id), 45099.2737545718, 4.18, 4396.5, 'true', 2),
((select id from t_id), (select id from i_id), 45099.2741789931, 2.09, 4395.5, 'true', 1),
((select id from t_id), (select id from i_id), 45099.2741790046, 2.09, 4395.5, 'true', 1),
((select id from t_id), (select id from i_id), 45099.2748826852, 8.36, 4398, 'false', 4),
((select id from t_id), (select id from i_id), 45099.274884838, 4.18, 4398, 'false', 2);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45103.2939706829, 45103.2958026505, 8.36, 200, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45103.2939706829, 4.18, 4398.75, 'true', 2),
((select id from t_id), (select id from i_id), 45103.2958026389, 2.09, 4400.75, 'false', 1),
((select id from t_id), (select id from i_id), 45103.2958026505, 2.09, 4400.75, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45104.2790908681, 45104.2798805093, 8.36, 175, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45104.2790908681, 4.18, 4385.75, 'true', 2),
((select id from t_id), (select id from i_id), 45104.279880463, 2.09, 4387.5, 'false', 1),
((select id from t_id), (select id from i_id), 45104.2798805093, 2.09, 4387.5, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45105.2748705208, 45105.2765070718, 8.36, -200, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45105.2748705208, 4.18, 4403.5, 'false', 2),
((select id from t_id), (select id from i_id), 45105.2765070602, 2.09, 4405.5, 'true', 1),
((select id from t_id), (select id from i_id), 45105.2765070718, 2.09, 4405.5, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45105.27665125, 45105.2824373843, 33.44, -1725, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45105.27665125, 4.18, 4405.25, 'true', 2),
((select id from t_id), (select id from i_id), 45105.2811429398, 4.18, 4405, 'true', 2),
((select id from t_id), (select id from i_id), 45105.2819349306, 8.36, 4402, 'true', 4),
((select id from t_id), (select id from i_id), 45105.2824372917, 8.36, 4399.25, 'false', 4),
((select id from t_id), (select id from i_id), 45105.282437338, 4.18, 4399.25, 'false', 2),
((select id from t_id), (select id from i_id), 45105.2824373843, 4.18, 4399.25, 'false', 2);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45105.2826933681, 45105.2829770949, 33.44, -500, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45105.2826933681, 16.72, 4400.5, 'false', 8),
((select id from t_id), (select id from i_id), 45105.2829770949, 16.72, 4401.75, 'true', 8);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45124.2736289815, 45124.2760475116, 41.8, 937.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45124.2736289815, 8.36, 4541.25, 'true', 4),
((select id from t_id), (select id from i_id), 45124.2744219213, 8.36, 4539.5, 'true', 4),
((select id from t_id), (select id from i_id), 45124.2750357639, 2.09, 4538.5, 'true', 1),
((select id from t_id), (select id from i_id), 45124.2750393056, 2.09, 4538.5, 'true', 1),
((select id from t_id), (select id from i_id), 45124.275840081, 6.27, 4541.25, 'false', 3),
((select id from t_id), (select id from i_id), 45124.2758423727, 8.36, 4541.25, 'false', 4),
((select id from t_id), (select id from i_id), 45124.2758423843, 4.18, 4541.25, 'false', 2),
((select id from t_id), (select id from i_id), 45124.2760475116, 2.09, 4542.25, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45001.4287152778, 45001.4305376736, 0, 6.25, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45001.4287152778, 0, 3982, 'true', 1),
((select id from t_id), (select id from i_id), 45001.4305376736, 0, 3983.25, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45002.2815531597, 45002.2858166088, 2.24, 17.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45002.2815531597, 0.56, 3977, 'true', 1),
((select id from t_id), (select id from i_id), 45002.2842982176, 0.56, 3972.5, 'true', 1),
((select id from t_id), (select id from i_id), 45002.2858166088, 1.12, 3976.5, 'false', 2);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45002.2900201852, 45002.2904660764, 1.12, 6.25, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45002.2900201852, 0.56, 3977.5, 'false', 1),
((select id from t_id), (select id from i_id), 45002.2904660764, 0.56, 3976.25, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45002.2998391551, 45002.3268311574, 4.48, -400, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45002.2998391551, 0.56, 3977.5, 'true', 1),
((select id from t_id), (select id from i_id), 45002.3042970949, 0.56, 3972.75, 'true', 1),
((select id from t_id), (select id from i_id), 45002.3051608449, 0.56, 3967, 'true', 1),
((select id from t_id), (select id from i_id), 45002.308958831, 0.56, 3960.75, 'true', 1),
((select id from t_id), (select id from i_id), 45002.3268311574, 2.24, 3949.5, 'false', 4);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45005.2669307523, 45005.2709250926, 1.22, 10, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45005.2669307523, 0.61, 3954.5, 'true', 1),
((select id from t_id), (select id from i_id), 45005.2709250926, 0.61, 3956.5, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45005.2717371296, 45005.2740734144, 2.44, 8.75, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45005.2717371296, 0.61, 3953, 'false', 1),
((select id from t_id), (select id from i_id), 45005.2731026852, 0.61, 3961.75, 'false', 1),
((select id from t_id), (select id from i_id), 45005.2740734028, 0.61, 3956.5, 'true', 1),
((select id from t_id), (select id from i_id), 45005.2740734144, 0.61, 3956.5, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45005.2817161458, 45005.2822903125, 1.22, 20, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45005.2817161458, 0.61, 3957.75, 'false', 1),
((select id from t_id), (select id from i_id), 45005.2822903125, 0.61, 3953.75, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45005.2903604167, 45005.2910854514, 1.22, 10, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45005.2903604167, 0.61, 3965.5, 'false', 1),
((select id from t_id), (select id from i_id), 45005.2910854514, 0.61, 3963.5, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45005.2991106481, 45005.2993805671, 1.22, 6.25, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45005.2991106481, 0.61, 3962.75, 'true', 1),
((select id from t_id), (select id from i_id), 45005.2993805671, 0.61, 3964, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45005.302863912, 45005.3032309838, 1.22, 2.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45005.302863912, 0.61, 3966.25, 'true', 1),
((select id from t_id), (select id from i_id), 45005.3032309838, 0.61, 3966.75, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45006.2887456481, 45006.2905062732, 1.22, -6.25, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45006.2887456481, 0.61, 4024.25, 'false', 1),
((select id from t_id), (select id from i_id), 45006.2905062732, 0.61, 4025.5, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45006.2950332407, 45006.2957475, 1.22, 10, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45006.2950332407, 0.61, 4023, 'false', 1),
((select id from t_id), (select id from i_id), 45006.2957475, 0.61, 4021, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45006.3158831366, 45006.3168117824, 1.22, -10, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45006.3158831366, 0.61, 4010, 'true', 1),
((select id from t_id), (select id from i_id), 45006.3168117824, 0.61, 4008, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45006.3279012384, 45006.3296961574, 1.22, 1.25, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45006.3279012384, 0.61, 4009.75, 'true', 1),
((select id from t_id), (select id from i_id), 45006.3296961574, 0.61, 4010, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45006.3515984838, 45006.3519400347, 1.22, 16.25, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45006.3515984838, 0.61, 4019.25, 'false', 1),
((select id from t_id), (select id from i_id), 45006.3519400347, 0.61, 4016, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45007.3079119792, 45007.3105551505, 1.22, -11.25, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45007.3079119792, 0.61, 4039.5, 'false', 1),
((select id from t_id), (select id from i_id), 45007.3105551505, 0.61, 4041.75, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45007.3152387268, 45007.320608669, 1.22, 3.75, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45007.3152387268, 0.61, 4044.25, 'false', 1),
((select id from t_id), (select id from i_id), 45007.320608669, 0.61, 4043.5, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45007.343338588, 45007.3439625116, 1.22, 5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45007.343338588, 0.61, 4035, 'true', 1),
((select id from t_id), (select id from i_id), 45007.3439625116, 0.61, 4036, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45007.4182909491, 45007.4212318982, 1.22, -11.25, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45007.4182909491, 0.61, 4024.75, 'true', 1),
((select id from t_id), (select id from i_id), 45007.4212318982, 0.61, 4022.5, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45007.4614579398, 45007.4619141204, 1.22, -23.75, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45007.4614579398, 0.61, 4050.5, 'false', 1),
((select id from t_id), (select id from i_id), 45007.4619141204, 0.61, 4055.25, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45007.4625137384, 45007.4625593519, 1.22, -10, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45007.4625137384, 0.61, 4058.5, 'false', 1),
((select id from t_id), (select id from i_id), 45007.4625593519, 0.61, 4060.5, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45007.4627706366, 45007.4632565856, 1.22, 27.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45007.4627706366, 0.61, 4064.75, 'false', 1),
((select id from t_id), (select id from i_id), 45007.4632565856, 0.61, 4059.25, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45007.4640017245, 45007.4641708102, 1.22, 6.25, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45007.4640017245, 0.61, 4054.75, 'true', 1),
((select id from t_id), (select id from i_id), 45007.4641708102, 0.61, 4056, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45007.4646881366, 45007.4664197685, 2.44, -60, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45007.4646881366, 0.61, 4052.25, 'true', 1),
((select id from t_id), (select id from i_id), 45007.4663102662, 0.61, 4048.75, 'true', 1),
((select id from t_id), (select id from i_id), 45007.4664196412, 0.61, 4044.5, 'false', 1),
((select id from t_id), (select id from i_id), 45007.4664197685, 0.61, 4044.5, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45007.4679842014, 45007.4679925116, 1.22, -1.25, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45007.4679842014, 0.61, 4038.75, 'false', 1),
((select id from t_id), (select id from i_id), 45007.4679925116, 0.61, 4039, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45008.2850027778, 45008.2853019907, 1.22, 10, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45008.2850027778, 0.61, 4005.75, 'false', 1),
((select id from t_id), (select id from i_id), 45008.2853019907, 0.61, 4003.75, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45008.3009036806, 45008.3018020255, 1.22, 7.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45008.3009036806, 0.61, 4012.25, 'true', 1),
((select id from t_id), (select id from i_id), 45008.3018020255, 0.61, 4013.75, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45008.3071957407, 45008.3072578009, 1.22, 3.75, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45008.3071957407, 0.61, 4010.25, 'true', 1),
((select id from t_id), (select id from i_id), 45008.3072578009, 0.61, 4011, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45008.3166663889, 45008.3169735995, 1.22, -10, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45008.3166663889, 0.61, 4012.25, 'true', 1),
((select id from t_id), (select id from i_id), 45008.3169735995, 0.61, 4010.25, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45008.3174514931, 45008.3183904282, 1.22, 5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45008.3174514931, 0.61, 4011.5, 'true', 1),
((select id from t_id), (select id from i_id), 45008.3183904282, 0.61, 4012.5, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45008.3222717477, 45008.3224348727, 1.22, 5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45008.3222717477, 0.61, 4017.75, 'false', 1),
((select id from t_id), (select id from i_id), 45008.3224348727, 0.61, 4016.75, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45008.4970001968, 45008.4970437268, 1.22, 10, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45008.4970001968, 0.61, 3952.25, 'true', 1),
((select id from t_id), (select id from i_id), 45008.4970437268, 0.61, 3954.25, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45009.2486299768, 45009.2505709375, 1.22, 10, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45009.2486299768, 0.61, 3955.5, 'false', 1),
((select id from t_id), (select id from i_id), 45009.2505709375, 0.61, 3953.5, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45009.2739253241, 45009.2741835069, 1.22, 5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45009.2739253241, 0.61, 3955.75, 'true', 1),
((select id from t_id), (select id from i_id), 45009.2741835069, 0.61, 3956.75, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45009.3224161574, 45009.3232572569, 1.22, 10, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45009.3224161574, 0.61, 3956, 'true', 1),
((select id from t_id), (select id from i_id), 45009.3232572569, 0.61, 3958, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45012.2709516435, 45012.2713721181, 1.22, 10, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45012.2709516435, 0.61, 4026.75, 'false', 1),
((select id from t_id), (select id from i_id), 45012.2713721181, 0.61, 4024.75, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45012.3111013773, 45012.3154716551, 2.44, -52.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45012.3111013773, 0.61, 4019.25, 'true', 1),
((select id from t_id), (select id from i_id), 45012.313148044, 0.61, 4012.25, 'true', 1),
((select id from t_id), (select id from i_id), 45012.3154714236, 0.61, 4010.5, 'false', 1),
((select id from t_id), (select id from i_id), 45012.3154716551, 0.61, 4010.5, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45012.318933831, 45012.324291088, 2.44, 22.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45012.318933831, 0.61, 4011.75, 'true', 1),
((select id from t_id), (select id from i_id), 45012.3230728125, 0.61, 4008.25, 'true', 1),
((select id from t_id), (select id from i_id), 45012.324291088, 1.22, 4012.25, 'false', 2);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45012.3248559375, 45012.3252386458, 1.22, 15, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45012.3248559375, 0.61, 4013.25, 'false', 1),
((select id from t_id), (select id from i_id), 45012.3252386458, 0.61, 4010.25, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45012.3337742824, 45012.3354159838, 2.44, 10, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45012.3337742824, 0.61, 4009.25, 'true', 1),
((select id from t_id), (select id from i_id), 45012.3351081597, 0.61, 4007.25, 'true', 1),
((select id from t_id), (select id from i_id), 45012.3354159722, 0.61, 4009.25, 'false', 1),
((select id from t_id), (select id from i_id), 45012.3354159838, 0.61, 4009.25, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45012.467196088, 45012.4804500116, 6.1, -112.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45012.467196088, 0.61, 4012.5, 'false', 1),
((select id from t_id), (select id from i_id), 45012.4704912847, 0.61, 4015.25, 'false', 1),
((select id from t_id), (select id from i_id), 45012.4737848032, 0.61, 4017.75, 'false', 1),
((select id from t_id), (select id from i_id), 45012.4765186574, 1.22, 4021, 'false', 2),
((select id from t_id), (select id from i_id), 45012.480449919, 0.61, 4022, 'true', 1),
((select id from t_id), (select id from i_id), 45012.4804499537, 0.61, 4022, 'true', 1),
((select id from t_id), (select id from i_id), 45012.4804499653, 0.61, 4022, 'true', 1),
((select id from t_id), (select id from i_id), 45012.4804500116, 1.22, 4022, 'true', 2);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45013.2467640162, 45013.2484040857, 1.22, 5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45013.2467640162, 0.61, 3998.25, 'true', 1),
((select id from t_id), (select id from i_id), 45013.2484040857, 0.61, 3999.25, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45013.2716695023, 45013.2718007755, 1.22, 2.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45013.2716695023, 0.61, 3999, 'false', 1),
((select id from t_id), (select id from i_id), 45013.2718007755, 0.61, 3998.5, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45013.2724773495, 45013.2742562153, 4.88, 17.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45013.2724773495, 1.22, 3997.75, 'true', 2),
((select id from t_id), (select id from i_id), 45013.2735604167, 0.61, 3994.5, 'true', 1),
((select id from t_id), (select id from i_id), 45013.2737028125, 0.61, 3994.5, 'true', 1),
((select id from t_id), (select id from i_id), 45013.2739960532, 1.83, 3996.75, 'false', 3),
((select id from t_id), (select id from i_id), 45013.2742562153, 0.61, 3998.75, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45013.2746847685, 45013.2764537616, 2.44, 15, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45013.2746847685, 1.22, 3998.75, 'false', 2),
((select id from t_id), (select id from i_id), 45013.2756964005, 0.61, 3996.75, 'true', 1),
((select id from t_id), (select id from i_id), 45013.2764537616, 0.61, 3997.75, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45013.2777520255, 45013.2780881944, 1.22, 6.25, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45013.2777520255, 0.61, 3999.75, 'true', 1),
((select id from t_id), (select id from i_id), 45013.2780881944, 0.61, 4001, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45013.2806020718, 45013.2810858449, 1.22, 3.75, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45013.2806020718, 0.61, 4000.75, 'false', 1),
((select id from t_id), (select id from i_id), 45013.2810858449, 0.61, 4000, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45013.293859375, 45013.3067353819, 7.320000000000001, 16.25, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45013.293859375, 0.61, 3999.5, 'false', 1),
((select id from t_id), (select id from i_id), 45013.294672037, 0.61, 4003.75, 'false', 1),
((select id from t_id), (select id from i_id), 45013.2973008449, 0.61, 4005.25, 'false', 1),
((select id from t_id), (select id from i_id), 45013.2995917361, 1.83, 4007.75, 'false', 3),
((select id from t_id), (select id from i_id), 45013.3067353356, 0.61, 4004.75, 'true', 1),
((select id from t_id), (select id from i_id), 45013.3067353704, 2.44, 4004.75, 'true', 4),
((select id from t_id), (select id from i_id), 45013.3067353819, 0.61, 4004.75, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45014.3315052431, 45014.3326086227, 2.44, 23.75, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45014.3315052431, 1.22, 4035.5, 'false', 2),
((select id from t_id), (select id from i_id), 45014.3320979745, 0.61, 4033.5, 'true', 1),
((select id from t_id), (select id from i_id), 45014.3326086227, 0.61, 4032.75, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45014.4202280208, 45014.4271693403, 2.44, 35, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45014.4202280208, 1.22, 4042.5, 'true', 2),
((select id from t_id), (select id from i_id), 45014.4217004745, 0.61, 4044.5, 'false', 1),
((select id from t_id), (select id from i_id), 45014.4271693403, 0.61, 4047.5, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45014.441953206, 45014.4437609722, 1.22, -10, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45014.441953206, 0.61, 4043.5, 'true', 1),
((select id from t_id), (select id from i_id), 45014.4437609722, 0.61, 4041.5, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45015.2919196875, 45015.2923428357, 2.44, 12.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45015.2919196875, 1.22, 4086.5, 'false', 2),
((select id from t_id), (select id from i_id), 45015.2922962153, 0.61, 4085.25, 'true', 1),
((select id from t_id), (select id from i_id), 45015.2923428357, 0.61, 4085.25, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45015.2954725116, 45015.3005606366, 2.44, -65, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45015.2954725116, 1.22, 4079.25, 'true', 2),
((select id from t_id), (select id from i_id), 45015.3005606366, 1.22, 4072.75, 'false', 2);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45015.3007590162, 45015.3034901389, 4.88, 32.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45015.3007590162, 0.61, 4073.75, 'false', 1),
((select id from t_id), (select id from i_id), 45015.3007596528, 0.61, 4073.75, 'false', 1),
((select id from t_id), (select id from i_id), 45015.3027421412, 1.22, 4074.75, 'false', 2),
((select id from t_id), (select id from i_id), 45015.3033270718, 1.22, 4072.5, 'true', 2),
((select id from t_id), (select id from i_id), 45015.3034901389, 1.22, 4072.75, 'true', 2);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45016.3032265972, 45016.3033504051, 2.44, 2.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45016.3032265972, 1.22, 4099, 'false', 2),
((select id from t_id), (select id from i_id), 45016.3033504051, 1.22, 4098.75, 'true', 2);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45016.3112995139, 45016.3119839931, 1.22, 5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45016.3112995139, 0.61, 4102.75, 'false', 1),
((select id from t_id), (select id from i_id), 45016.3119839931, 0.61, 4101.75, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45019.272530706, 45019.2752385301, 4.88, -85, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45019.272530706, 1.22, 4134.75, 'false', 2),
((select id from t_id), (select id from i_id), 45019.2745575116, 1.22, 4138.25, 'false', 2),
((select id from t_id), (select id from i_id), 45019.2752385185, 0.61, 4140.75, 'true', 1),
((select id from t_id), (select id from i_id), 45019.2752385301, 1.83, 4140.75, 'true', 3);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45019.2756075, 45019.2775749769, 2.44, 5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45019.2756075, 1.22, 4141.5, 'true', 2),
((select id from t_id), (select id from i_id), 45019.2775749769, 1.22, 4142, 'false', 2);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45019.2876565509, 45019.2880592708, 2.44, -22.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45019.2876565509, 1.22, 4148.75, 'true', 2),
((select id from t_id), (select id from i_id), 45019.2880592708, 1.22, 4146.5, 'false', 2);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45027.3092046875, 45027.3156625694, 2.44, 12.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45027.3092046875, 1.22, 4137.5, 'false', 2),
((select id from t_id), (select id from i_id), 45027.3156625463, 0.61, 4136.25, 'true', 1),
((select id from t_id), (select id from i_id), 45027.3156625694, 0.61, 4136.25, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45027.319810081, 45027.3216613426, 2.44, 2.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45027.319810081, 1.22, 4133.5, 'true', 2),
((select id from t_id), (select id from i_id), 45027.3199614583, 0.61, 4133.75, 'false', 1),
((select id from t_id), (select id from i_id), 45027.3216613426, 0.61, 4133.75, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45027.3266606481, 45027.3288249306, 2.44, 2.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45027.3266606481, 1.22, 4133.75, 'false', 2),
((select id from t_id), (select id from i_id), 45027.3271503819, 0.61, 4133.5, 'true', 1),
((select id from t_id), (select id from i_id), 45027.3288249306, 0.61, 4133.5, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45034.2629421644, 45034.2665677778, 1.22, -10, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45034.2629421644, 0.61, 4194, 'true', 1),
((select id from t_id), (select id from i_id), 45034.2665677778, 0.61, 4192, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45034.2684518519, 45034.271393831, 3.66, -30, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45034.2684518519, 1.83, 4192.25, 'true', 3),
((select id from t_id), (select id from i_id), 45034.271393831, 1.83, 4190.25, 'false', 3);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45034.2717935532, 45034.2722366898, 3.66, -30, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45034.2717935532, 1.83, 4190, 'true', 3),
((select id from t_id), (select id from i_id), 45034.2722366667, 0.61, 4188, 'false', 1),
((select id from t_id), (select id from i_id), 45034.2722366898, 1.22, 4188, 'false', 2);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45034.2726818287, 45034.2830572222, 3.6599999999999997, 35, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45034.2726818287, 0.61, 4189.5, 'true', 1),
((select id from t_id), (select id from i_id), 45034.2726818403, 0.61, 4189.5, 'true', 1),
((select id from t_id), (select id from i_id), 45034.2726845486, 0.61, 4189.5, 'true', 1),
((select id from t_id), (select id from i_id), 45034.2777883796, 1.22, 4191.5, 'false', 2),
((select id from t_id), (select id from i_id), 45034.2830572222, 0.61, 4192.5, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45034.2940175926, 45034.2947559028, 1.22, -10, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45034.2940175926, 0.61, 4179.25, 'true', 1),
((select id from t_id), (select id from i_id), 45034.2947559028, 0.61, 4177.25, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45034.2955554398, 45034.2983780324, 3.6599999999999997, 35, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45034.2955554398, 1.83, 4178, 'true', 3),
((select id from t_id), (select id from i_id), 45034.2970851736, 0.61, 4180, 'false', 1),
((select id from t_id), (select id from i_id), 45034.2970853356, 0.61, 4180, 'false', 1),
((select id from t_id), (select id from i_id), 45034.2983780324, 0.61, 4181, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45034.3217852431, 45034.3277647222, 1.22, 10, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45034.3217852431, 0.61, 4173.5, 'false', 1),
((select id from t_id), (select id from i_id), 45034.3277647222, 0.61, 4171.5, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45035.252985706, 45035.2546846644, 3.66, -30, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45035.252985706, 1.83, 4154.75, 'false', 3),
((select id from t_id), (select id from i_id), 45035.2546846528, 0.61, 4156.75, 'true', 1),
((select id from t_id), (select id from i_id), 45035.2546846644, 1.22, 4156.75, 'true', 2);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45035.2614843519, 45035.2679817361, 3.66, 0, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45035.2614843519, 1.83, 4158.25, 'false', 3),
((select id from t_id), (select id from i_id), 45035.2679815625, 0.61, 4158.25, 'true', 1),
((select id from t_id), (select id from i_id), 45035.2679817361, 1.22, 4158.25, 'true', 2);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45035.2720327315, 45035.2727511111, 3.66, -33.75, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45035.2720327315, 1.83, 4160, 'false', 3),
((select id from t_id), (select id from i_id), 45035.2727511111, 1.83, 4162.25, 'true', 3);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45035.2736317593, 45035.2756699074, 3.6599999999999997, -30, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45035.2736317593, 1.83, 4160.75, 'true', 3),
((select id from t_id), (select id from i_id), 45035.2756694213, 1.22, 4158.75, 'false', 2),
((select id from t_id), (select id from i_id), 45035.2756699074, 0.61, 4158.75, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45035.2759147917, 45035.2821681597, 3.6599999999999997, 20, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45035.2759147917, 1.83, 4161, 'false', 3),
((select id from t_id), (select id from i_id), 45035.2778952893, 1.22, 4159, 'true', 2),
((select id from t_id), (select id from i_id), 45035.2821681597, 0.61, 4161, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45035.284648912, 45035.2855463542, 3.66, -41.25, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45035.284648912, 1.83, 4159.25, 'false', 3),
((select id from t_id), (select id from i_id), 45035.2855463542, 1.83, 4162, 'true', 3);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45035.2857889236, 45035.3196152431, 3.66, 146.25, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45035.2857889236, 1.83, 4160, 'true', 3),
((select id from t_id), (select id from i_id), 45035.3196152315, 0.61, 4169.75, 'false', 1),
((select id from t_id), (select id from i_id), 45035.3196152431, 1.22, 4169.75, 'false', 2);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45036.2746767361, 45036.2757365394, 3.6599999999999997, 18.75, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45036.2746767361, 1.83, 4152.25, 'false', 3),
((select id from t_id), (select id from i_id), 45036.2757312847, 1.22, 4151, 'true', 2),
((select id from t_id), (select id from i_id), 45036.2757365394, 0.61, 4151, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45036.2829409375, 45036.2858338889, 3.6599999999999997, 12.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45036.2829409375, 1.83, 4154.5, 'true', 3),
((select id from t_id), (select id from i_id), 45036.2844504398, 1.22, 4156.5, 'false', 2),
((select id from t_id), (select id from i_id), 45036.2858338889, 0.61, 4153, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45125.272866412, 45125.2745236921, 4.88, -45, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45125.272866412, 2.44, 4547.5, 'false', 4),
((select id from t_id), (select id from i_id), 45125.2745236921, 2.44, 4549.75, 'true', 4);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45125.2754630787, 45125.2792057176, 4.88, 83.75, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45125.2754630787, 2.44, 4549.75, 'true', 4),
((select id from t_id), (select id from i_id), 45125.2789515509, 0.61, 4553.75, 'false', 1),
((select id from t_id), (select id from i_id), 45125.2789571991, 0.61, 4553.75, 'false', 1),
((select id from t_id), (select id from i_id), 45125.2789573148, 0.61, 4553.75, 'false', 1),
((select id from t_id), (select id from i_id), 45125.2792057176, 0.61, 4554.5, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45126.2865665509, 45126.2875762384, 4.88, -50, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45126.2865665509, 1.83, 4602.5, 'false', 3),
((select id from t_id), (select id from i_id), 45126.2865665625, 0.61, 4602.5, 'false', 1),
((select id from t_id), (select id from i_id), 45126.2875762269, 1.83, 4604.5, 'true', 3),
((select id from t_id), (select id from i_id), 45126.2875762384, 0.61, 4604.5, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45126.2882458102, 45126.2955184375, 4.88, -70, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45126.2882458102, 2.44, 4603.25, 'false', 4),
((select id from t_id), (select id from i_id), 45126.2955184375, 2.44, 4606.75, 'true', 4);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45126.2960599884, 45126.3333715046, 21.959999999999997, 177.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45126.2960599884, 2.44, 4605, 'true', 4),
((select id from t_id), (select id from i_id), 45126.3196609954, 1.22, 4602, 'true', 2),
((select id from t_id), (select id from i_id), 45126.329908588, 2.44, 4594.75, 'true', 4),
((select id from t_id), (select id from i_id), 45126.3300510301, 2.44, 4592.5, 'true', 4),
((select id from t_id), (select id from i_id), 45126.3307767361, 2.44, 4592.75, 'true', 4),
((select id from t_id), (select id from i_id), 45126.3317939468, 2.44, 4599.25, 'false', 4),
((select id from t_id), (select id from i_id), 45126.3317939699, 1.22, 4599.25, 'false', 2),
((select id from t_id), (select id from i_id), 45126.3317939931, 6.71, 4599.25, 'false', 11),
((select id from t_id), (select id from i_id), 45126.3333715046, 0.61, 4598, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45127.2725628009, 45127.2730473611, 4.88, -40, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45127.2725628009, 2.44, 4589, 'false', 4),
((select id from t_id), (select id from i_id), 45127.2730473495, 1.83, 4591, 'true', 3),
((select id from t_id), (select id from i_id), 45127.2730473611, 0.61, 4591, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45127.2739434375, 45127.2770729282, 4.88, 5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45127.2739434375, 2.44, 4592.5, 'false', 4),
((select id from t_id), (select id from i_id), 45127.2769348611, 1.83, 4592.25, 'true', 3),
((select id from t_id), (select id from i_id), 45127.2770729282, 0.61, 4592.25, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45127.2784283912, 45127.2892618519, 4.88, 85, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45127.2784283912, 1.83, 4590, 'true', 3),
((select id from t_id), (select id from i_id), 45127.2784284028, 0.61, 4590, 'true', 1),
((select id from t_id), (select id from i_id), 45127.2832072801, 1.83, 4594, 'false', 3),
((select id from t_id), (select id from i_id), 45127.2892618519, 0.61, 4591, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45127.3047484375, 45127.3226979167, 85.4, 362.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45127.3047484375, 2.44, 4582.5, 'true', 4),
((select id from t_id), (select id from i_id), 45127.3060795602, 2.44, 4578.25, 'true', 4),
((select id from t_id), (select id from i_id), 45127.3097373843, 7.32, 4577.25, 'true', 12),
((select id from t_id), (select id from i_id), 45127.3166205093, 2.44, 4573.75, 'true', 4),
((select id from t_id), (select id from i_id), 45127.3166212384, 9.76, 4573.75, 'true', 16),
((select id from t_id), (select id from i_id), 45127.3194527894, 2.44, 4571.25, 'true', 4),
((select id from t_id), (select id from i_id), 45127.3194535069, 15.86, 4571.25, 'true', 26),
((select id from t_id), (select id from i_id), 45127.3224865046, 18.3, 4575, 'false', 30),
((select id from t_id), (select id from i_id), 45127.3224865278, 0.61, 4575, 'false', 1),
((select id from t_id), (select id from i_id), 45127.3224865393, 11.59, 4575, 'false', 19),
((select id from t_id), (select id from i_id), 45127.3226971875, 2.44, 4575.25, 'false', 4),
((select id from t_id), (select id from i_id), 45127.3226979167, 9.76, 4575.25, 'false', 16);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45128.3090238542, 45128.3142924884, 19.52, 201.25, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45128.3090238542, 1.83, 4570, 'true', 3),
((select id from t_id), (select id from i_id), 45128.3090238657, 0.61, 4570, 'true', 1),
((select id from t_id), (select id from i_id), 45128.3107623727, 2.44, 4567.25, 'true', 4),
((select id from t_id), (select id from i_id), 45128.3120835764, 0.61, 4565.75, 'true', 1),
((select id from t_id), (select id from i_id), 45128.3120836458, 1.83, 4565.75, 'true', 3),
((select id from t_id), (select id from i_id), 45128.312385, 2.44, 4566, 'true', 4),
((select id from t_id), (select id from i_id), 45128.3142064583, 1.83, 4569.75, 'false', 3),
((select id from t_id), (select id from i_id), 45128.3142070718, 7.32, 4569.75, 'false', 12),
((select id from t_id), (select id from i_id), 45128.3142924884, 0.61, 4570.25, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45131.2666387153, 45131.2705509954, 4.88, -40, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45131.2666387153, 0.61, 4572.75, 'false', 1),
((select id from t_id), (select id from i_id), 45131.2667045833, 1.83, 4572.75, 'false', 3),
((select id from t_id), (select id from i_id), 45131.2705509954, 2.44, 4574.75, 'true', 4);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45131.2718757755, 45131.2724463194, 4.88, -40, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45131.2718757755, 0.61, 4581.25, 'false', 1),
((select id from t_id), (select id from i_id), 45131.271875787, 1.83, 4581.25, 'false', 3),
((select id from t_id), (select id from i_id), 45131.2724463194, 2.44, 4583.25, 'true', 4);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45131.2725961343, 45131.2772246759, 14.64, 200, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45131.2725961343, 2.44, 4582.25, 'false', 4),
((select id from t_id), (select id from i_id), 45131.2736357292, 1.22, 4582.25, 'false', 2),
((select id from t_id), (select id from i_id), 45131.2736357755, 1.22, 4582.25, 'false', 2),
((select id from t_id), (select id from i_id), 45131.2743269907, 0.61, 4585.5, 'false', 1),
((select id from t_id), (select id from i_id), 45131.2743270023, 1.83, 4585.5, 'false', 3),
((select id from t_id), (select id from i_id), 45131.2772240741, 1.83, 4580, 'true', 3),
((select id from t_id), (select id from i_id), 45131.2772246759, 5.49, 4580, 'true', 9);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45132.2726080208, 45132.279664375, 4.88, 70, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45132.2726080208, 2.44, 4580.5, 'true', 4),
((select id from t_id), (select id from i_id), 45132.2733971875, 1.83, 4583.5, 'false', 3),
((select id from t_id), (select id from i_id), 45132.279664375, 0.61, 4585.5, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45133.276187419, 45133.2765282176, 4.88, -40, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45133.276187419, 2.44, 4586.75, 'false', 4),
((select id from t_id), (select id from i_id), 45133.2765280208, 1.83, 4588.75, 'true', 3),
((select id from t_id), (select id from i_id), 45133.2765282176, 0.61, 4588.75, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45133.2766553009, 45133.2796181829, 9.76, 85, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45133.2766553009, 0.61, 4589, 'true', 1),
((select id from t_id), (select id from i_id), 45133.2766553125, 1.83, 4589, 'true', 3),
((select id from t_id), (select id from i_id), 45133.2772378935, 2.44, 4587.25, 'true', 4),
((select id from t_id), (select id from i_id), 45133.2793883565, 0.61, 4590.25, 'false', 1),
((select id from t_id), (select id from i_id), 45133.2793884259, 0.61, 4590.25, 'false', 1),
((select id from t_id), (select id from i_id), 45133.2793929977, 0.61, 4590.25, 'false', 1),
((select id from t_id), (select id from i_id), 45133.2793964352, 2.44, 4590.25, 'false', 4),
((select id from t_id), (select id from i_id), 45133.2796181829, 0.61, 4590.25, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45133.2887416782, 45133.2891748495, 4.88, -40, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45133.2887416782, 2.44, 4588.75, 'true', 4),
((select id from t_id), (select id from i_id), 45133.2891747685, 1.83, 4586.75, 'false', 3),
((select id from t_id), (select id from i_id), 45133.2891748495, 0.61, 4586.75, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45133.2900799074, 45133.2936100926, 4.88, -40, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45133.2900799074, 2.44, 4588.25, 'true', 4),
((select id from t_id), (select id from i_id), 45133.2936100926, 2.44, 4586.25, 'false', 4);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-05!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45134.2758008681, 45134.3091853009, 163.48, -2540, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45134.2758008681, 2.44, 4630.25, 'true', 4),
((select id from t_id), (select id from i_id), 45134.2834688079, 2.44, 4629.75, 'true', 4),
((select id from t_id), (select id from i_id), 45134.2846023843, 2.44, 4629.5, 'true', 4),
((select id from t_id), (select id from i_id), 45134.284602963, 2.44, 4629.5, 'true', 4),
((select id from t_id), (select id from i_id), 45134.2883385185, 9.76, 4629, 'true', 16),
((select id from t_id), (select id from i_id), 45134.2897947917, 4.88, 4627.5, 'true', 8),
((select id from t_id), (select id from i_id), 45134.2898078009, 1.22, 4627.5, 'true', 2),
((select id from t_id), (select id from i_id), 45134.2898251042, 1.22, 4627.5, 'true', 2),
((select id from t_id), (select id from i_id), 45134.2898257407, 7.93, 4627.5, 'true', 13),
((select id from t_id), (select id from i_id), 45134.2898257523, 3.05, 4627.5, 'true', 5),
((select id from t_id), (select id from i_id), 45134.2936927431, 2.44, 4629.5, 'false', 4),
((select id from t_id), (select id from i_id), 45134.2936927546, 20.74, 4629.5, 'false', 34),
((select id from t_id), (select id from i_id), 45134.2958026505, 2.44, 4625.5, 'true', 4),
((select id from t_id), (select id from i_id), 45134.2958026736, 12.2, 4625.5, 'true', 20),
((select id from t_id), (select id from i_id), 45134.2978031597, 29.28, 4623, 'true', 48),
((select id from t_id), (select id from i_id), 45134.3091853009, 58.56, 4619.25, 'false', 96);


insert into accounts (user_id, name, sim)
values ('6982c6df-3d03-4583-8fa9-07386cf25f80', 'APEX-30411-11!Apex!Apex', false)
on conflict ("name") do nothing;

insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-11!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45149.2533559838, 45149.2551267361, 0, 200, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45149.2533559838, 0, 4471.75, 'true', 2),
((select id from t_id), (select id from i_id), 45149.2551267361, 0, 4473.75, 'false', 2);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-11!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45149.2709304745, 45149.2716587847, 0, 100, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45149.2709304745, 0, 4465.5, 'false', 1),
((select id from t_id), (select id from i_id), 45149.2716587847, 0, 4463.5, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-11!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45149.2824860185, 45149.2858437616, 12.54, 150, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45149.2824860185, 2.09, 4462.75, 'false', 1),
((select id from t_id), (select id from i_id), 45149.2828219329, 2.09, 4464.5, 'false', 1),
((select id from t_id), (select id from i_id), 45149.2841944907, 2.09, 4466.25, 'false', 1),
((select id from t_id), (select id from i_id), 45149.2858437153, 2.09, 4463.5, 'true', 1),
((select id from t_id), (select id from i_id), 45149.2858437384, 2.09, 4463.5, 'true', 1),
((select id from t_id), (select id from i_id), 45149.2858437616, 2.09, 4463.5, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-11!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45152.2746565162, 45152.2750099769, 8.36, -175, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45152.2746565162, 2.09, 4474.75, 'true', 1),
((select id from t_id), (select id from i_id), 45152.2749828009, 2.09, 4473.25, 'true', 1),
((select id from t_id), (select id from i_id), 45152.2750099769, 4.18, 4472.25, 'false', 2);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-11!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45152.2751891551, 45152.2757565856, 4.18, -100, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45152.2751891551, 2.09, 4472.25, 'true', 1),
((select id from t_id), (select id from i_id), 45152.2757565856, 2.09, 4470.25, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-11!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45152.2760235648, 45152.2800205556, 4.18, 262.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45152.2760235648, 2.09, 4471.5, 'true', 1),
((select id from t_id), (select id from i_id), 45152.2800205556, 2.09, 4476.75, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-11!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45152.2848836921, 45152.285210787, 4.18, -100, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45152.2848836921, 2.09, 4470.25, 'false', 1),
((select id from t_id), (select id from i_id), 45152.285210787, 2.09, 4472.25, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-11!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45152.2876257639, 45152.2885159838, 4.18, -100, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45152.2876257639, 2.09, 4475.75, 'true', 1),
((select id from t_id), (select id from i_id), 45152.2885159838, 2.09, 4473.75, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-11!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45152.2886700926, 45152.2903965046, 8.36, 150, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45152.2886700926, 2.09, 4474, 'true', 1),
((select id from t_id), (select id from i_id), 45152.2899776968, 2.09, 4475, 'true', 1),
((select id from t_id), (select id from i_id), 45152.2903959259, 2.09, 4476, 'false', 1),
((select id from t_id), (select id from i_id), 45152.2903965046, 2.09, 4476, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-11!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45152.3145656713, 45152.3151292245, 4.18, 50, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45152.3145656713, 2.09, 4486, 'true', 1),
((select id from t_id), (select id from i_id), 45152.3151292245, 2.09, 4487, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-11!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45152.3366284722, 45152.3375335069, 4.18, 62.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45152.3366284722, 2.09, 4495.5, 'false', 1),
((select id from t_id), (select id from i_id), 45152.3375335069, 2.09, 4494.25, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-11!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45152.536720787, 45152.5375173264, 4.18, 50, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45152.536720787, 2.09, 4497.5, 'true', 1),
((select id from t_id), (select id from i_id), 45152.5375173264, 2.09, 4498.5, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-11!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45153.2460461111, 45153.2476400116, 4.18, 50, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45153.2460461111, 2.09, 4475.75, 'true', 1),
((select id from t_id), (select id from i_id), 45153.2476400116, 2.09, 4476.75, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-11!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45153.2653580787, 45153.2709309375, 4.18, -125, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45153.2653580787, 2.09, 4486, 'false', 1),
((select id from t_id), (select id from i_id), 45153.2709309375, 2.09, 4488.5, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-11!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45153.2712760764, 45153.2715549884, 4.18, -100, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45153.2712760764, 2.09, 4488.75, 'false', 1),
((select id from t_id), (select id from i_id), 45153.2715549884, 2.09, 4490.75, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-11!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45153.2715988079, 45153.2735499306, 8.36, 187.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45153.2715988079, 2.09, 4489.5, 'false', 1),
((select id from t_id), (select id from i_id), 45153.2730957986, 2.09, 4490.25, 'false', 1),
((select id from t_id), (select id from i_id), 45153.273549919, 2.09, 4488, 'true', 1),
((select id from t_id), (select id from i_id), 45153.2735499306, 2.09, 4488, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-11!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45153.2765245949, 45153.2766767824, 4.18, 62.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45153.2765245949, 2.09, 4486.5, 'true', 1),
((select id from t_id), (select id from i_id), 45153.2766767824, 2.09, 4487.75, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-11!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45154.288733125, 45154.2892671875, 4.18, 12.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45154.288733125, 2.09, 4458.5, 'false', 1),
((select id from t_id), (select id from i_id), 45154.2892671875, 2.09, 4458.25, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-11!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45154.2908248264, 45154.2910753009, 4.18, 12.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45154.2908248264, 2.09, 4460, 'false', 1),
((select id from t_id), (select id from i_id), 45154.2910753009, 2.09, 4459.75, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-11!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45154.3130645255, 45154.313173287, 4.18, 25, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45154.3130645255, 2.09, 4458, 'true', 1),
((select id from t_id), (select id from i_id), 45154.313173287, 2.09, 4458.5, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-11!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45155.2599210648, 45155.2710275347, 4.18, 50, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45155.2599210648, 2.09, 4433, 'true', 1),
((select id from t_id), (select id from i_id), 45155.2710275347, 2.09, 4434, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-11!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45155.2826205671, 45155.2830533218, 4.18, 12.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45155.2826205671, 2.09, 4426, 'true', 1),
((select id from t_id), (select id from i_id), 45155.2830533218, 2.09, 4426.25, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-11!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45155.288605625, 45155.2888526389, 4.18, 12.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45155.288605625, 2.09, 4421, 'false', 1),
((select id from t_id), (select id from i_id), 45155.2888526389, 2.09, 4420.75, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-11!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45155.291363125, 45155.2922297685, 4.18, -100, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45155.291363125, 2.09, 4425, 'false', 1),
((select id from t_id), (select id from i_id), 45155.2922297685, 2.09, 4427, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-11!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45155.2928885995, 45155.2945127662, 8.36, 100, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45155.2928885995, 2.09, 4426.5, 'true', 1),
((select id from t_id), (select id from i_id), 45155.2938846528, 2.09, 4424.5, 'true', 1),
((select id from t_id), (select id from i_id), 45155.2945127431, 2.09, 4426.5, 'false', 1),
((select id from t_id), (select id from i_id), 45155.2945127662, 2.09, 4426.5, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-11!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45155.2991427894, 45155.299344213, 4.18, -100, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45155.2991427894, 2.09, 4427, 'true', 1),
((select id from t_id), (select id from i_id), 45155.299344213, 2.09, 4425, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-11!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45155.2995757755, 45155.3004130324, 4.18, -100, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45155.2995757755, 2.09, 4426.25, 'true', 1),
((select id from t_id), (select id from i_id), 45155.3004130324, 2.09, 4424.25, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-11!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45155.3006179398, 45155.3012307639, 8.36, -162.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45155.3006179398, 2.09, 4423.75, 'true', 1),
((select id from t_id), (select id from i_id), 45155.3011553472, 2.09, 4422, 'true', 1),
((select id from t_id), (select id from i_id), 45155.3012307523, 2.09, 4421.25, 'false', 1),
((select id from t_id), (select id from i_id), 45155.3012307639, 2.09, 4421.25, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-11!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45155.3014698148, 45155.3021577778, 8.36, -200, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45155.3014698148, 2.09, 4421, 'false', 1),
((select id from t_id), (select id from i_id), 45155.3021459028, 2.09, 4424, 'false', 1),
((select id from t_id), (select id from i_id), 45155.3021574884, 2.09, 4424.5, 'true', 1),
((select id from t_id), (select id from i_id), 45155.3021577778, 2.09, 4424.5, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-11!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45155.3022182986, 45155.3027562963, 8.36, 275, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45155.3022182986, 2.09, 4424, 'true', 1),
((select id from t_id), (select id from i_id), 45155.3023634491, 2.09, 4424, 'true', 1),
((select id from t_id), (select id from i_id), 45155.3027562384, 2.09, 4426.75, 'false', 1),
((select id from t_id), (select id from i_id), 45155.3027562963, 2.09, 4426.75, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-11!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45155.3225776157, 45155.3241664005, 4.18, 75, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45155.3225776157, 2.09, 4418.5, 'true', 1),
((select id from t_id), (select id from i_id), 45155.3241664005, 2.09, 4420, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-11!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45155.324595463, 45155.3254398843, 4.18, -75, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45155.324595463, 2.09, 4419.5, 'false', 1),
((select id from t_id), (select id from i_id), 45155.3254398843, 2.09, 4421, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-11!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45159.2723368056, 45159.2726943634, 4.18, 87.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45159.2723368056, 2.09, 4394.25, 'true', 1),
((select id from t_id), (select id from i_id), 45159.2726943634, 2.09, 4396, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-11!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45159.2737576157, 45159.2739619907, 4.18, 87.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45159.2737576157, 2.09, 4396.5, 'true', 1),
((select id from t_id), (select id from i_id), 45159.2739619907, 2.09, 4398.25, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-11!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45159.2840618519, 45159.2845675694, 4.18, 50, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45159.2840618519, 2.09, 4397, 'true', 1),
((select id from t_id), (select id from i_id), 45159.2845675694, 2.09, 4398, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-11!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45159.3058902546, 45159.3061832755, 4.18, 25, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45159.3058902546, 2.09, 4395.75, 'true', 1),
((select id from t_id), (select id from i_id), 45159.3061832755, 2.09, 4396.25, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-11!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45160.2756916551, 45160.2763206134, 4.18, 62.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45160.2756916551, 2.09, 4426.25, 'false', 1),
((select id from t_id), (select id from i_id), 45160.2763206134, 2.09, 4425, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-11!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45160.2816376968, 45160.2820398148, 4.18, 50, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45160.2816376968, 2.09, 4423, 'false', 1),
((select id from t_id), (select id from i_id), 45160.2820398148, 2.09, 4422, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-11!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45160.3094652431, 45160.3100010185, 4.18, -100, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45160.3094652431, 2.09, 4416.5, 'true', 1),
((select id from t_id), (select id from i_id), 45160.3100010185, 2.09, 4414.5, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-11!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45160.3254989236, 45160.3280096065, 4.18, -62.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45160.3254989236, 2.09, 4411.25, 'false', 1),
((select id from t_id), (select id from i_id), 45160.3280096065, 2.09, 4412.5, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-11!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45160.3376707292, 45160.3380251505, 4.18, 62.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45160.3376707292, 2.09, 4411.25, 'true', 1),
((select id from t_id), (select id from i_id), 45160.3380251505, 2.09, 4412.5, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-11!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45161.2423340046, 45161.2465384838, 4.18, 137.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45161.2423340046, 2.09, 4405, 'false', 1),
((select id from t_id), (select id from i_id), 45161.2465384838, 2.09, 4402.25, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-11!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45162.2400791435, 45162.2407016782, 4.18, 112.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45162.2400791435, 2.09, 4465, 'true', 1),
((select id from t_id), (select id from i_id), 45162.2407016782, 2.09, 4467.25, 'false', 1);


insert into accounts (user_id, name, sim)
values ('6982c6df-3d03-4583-8fa9-07386cf25f80', 'APEX-30411-07!Apex!Apex', false)
on conflict ("name") do nothing;

insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-07!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45064.2682836111, 45064.2714389352, 0, 100, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45064.2682836111, 0, 4166.5, 'true', 1),
((select id from t_id), (select id from i_id), 45064.2711690046, 0, 4167, 'true', 1),
((select id from t_id), (select id from i_id), 45064.2714389352, 0, 4167.75, 'false', 2);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-07!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45064.2723770486, 45064.2803260069, 41.8, 487.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45064.2723770486, 2.09, 4165.75, 'false', 1),
((select id from t_id), (select id from i_id), 45064.273246713, 2.09, 4167.5, 'false', 1),
((select id from t_id), (select id from i_id), 45064.2762516435, 2.09, 4168.25, 'false', 1),
((select id from t_id), (select id from i_id), 45064.2762516551, 6.27, 4168.25, 'false', 3),
((select id from t_id), (select id from i_id), 45064.2769584144, 8.36, 4170.75, 'false', 4),
((select id from t_id), (select id from i_id), 45064.2803259838, 10.45, 4168, 'true', 5),
((select id from t_id), (select id from i_id), 45064.2803260069, 10.45, 4168, 'true', 5);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-07!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45065.2666371065, 45065.2687296296, 8.36, -275, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45065.2666371065, 4.18, 4225, 'true', 2),
((select id from t_id), (select id from i_id), 45065.2687296296, 4.18, 4222.25, 'false', 2);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-07!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45065.2696436343, 45065.2719273843, 25.08, 637.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45065.2696436343, 4.18, 4218.5, 'false', 2),
((select id from t_id), (select id from i_id), 45065.2706855903, 8.36, 4219.5, 'false', 4),
((select id from t_id), (select id from i_id), 45065.2717424074, 4.18, 4217.25, 'true', 2),
((select id from t_id), (select id from i_id), 45065.2717428356, 6.27, 4217.25, 'true', 3),
((select id from t_id), (select id from i_id), 45065.2719273843, 2.09, 4217.25, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-07!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45068.2719382176, 45068.2730333102, 8.36, -250, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45068.2719382176, 4.18, 4205.5, 'false', 2),
((select id from t_id), (select id from i_id), 45068.2730327778, 2.09, 4208, 'true', 1),
((select id from t_id), (select id from i_id), 45068.2730333102, 2.09, 4208, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-07!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45068.273546088, 45068.2736950116, 8.36, 212.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45068.273546088, 4.18, 4210.25, 'true', 2),
((select id from t_id), (select id from i_id), 45068.2736266667, 2.09, 4212.25, 'false', 1),
((select id from t_id), (select id from i_id), 45068.2736950116, 2.09, 4212.5, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-07!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45068.277050625, 45068.2785535532, 25.08, 312.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45068.277050625, 4.18, 4219.75, 'true', 2),
((select id from t_id), (select id from i_id), 45068.2773940856, 4.18, 4219.75, 'true', 2),
((select id from t_id), (select id from i_id), 45068.2778597454, 4.18, 4219.25, 'true', 2),
((select id from t_id), (select id from i_id), 45068.2785534722, 2.09, 4220.5, 'false', 1),
((select id from t_id), (select id from i_id), 45068.2785535417, 8.36, 4220.5, 'false', 4),
((select id from t_id), (select id from i_id), 45068.2785535532, 2.09, 4220.5, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-07!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45070.2743140278, 45070.2747119097, 16.72, 200, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45070.2743140278, 2.09, 4138.25, 'false', 1),
((select id from t_id), (select id from i_id), 45070.2743141088, 6.27, 4138.25, 'false', 3),
((select id from t_id), (select id from i_id), 45070.2747118981, 6.27, 4137.25, 'true', 3),
((select id from t_id), (select id from i_id), 45070.2747119097, 2.09, 4137.25, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-07!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45076.2609401273, 45076.2615255208, 8.36, -100, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45076.2609401273, 4.18, 4237.25, 'false', 2),
((select id from t_id), (select id from i_id), 45076.2615255208, 4.18, 4238.25, 'true', 2);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-07!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45076.2646591435, 45076.2730502894, 33.44, 312.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45076.2646591435, 4.18, 4237.25, 'true', 2),
((select id from t_id), (select id from i_id), 45076.2673541435, 4.18, 4235.75, 'true', 2),
((select id from t_id), (select id from i_id), 45076.2697312269, 8.36, 4235, 'true', 4),
((select id from t_id), (select id from i_id), 45076.2729271181, 2.09, 4236.75, 'false', 1),
((select id from t_id), (select id from i_id), 45076.2729275694, 12.54, 4236.75, 'false', 6),
((select id from t_id), (select id from i_id), 45076.2730502894, 2.09, 4235.5, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-07!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45077.2748847801, 45077.2760306829, 4.18, -100, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45077.2748847801, 2.09, 4193, 'false', 1),
((select id from t_id), (select id from i_id), 45077.2760306829, 2.09, 4195, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-07!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45077.2771536227, 45077.2777909259, 8.36, 200, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45077.2771536227, 4.18, 4195.75, 'true', 2),
((select id from t_id), (select id from i_id), 45077.2776930093, 2.09, 4197.75, 'false', 1),
((select id from t_id), (select id from i_id), 45077.2777909259, 2.09, 4197.75, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-07!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45077.2892607292, 45077.2906309606, 8.36, 100, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45077.2892607292, 4.18, 4194.25, 'false', 2),
((select id from t_id), (select id from i_id), 45077.2906309606, 4.18, 4193.25, 'true', 2);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-07!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45078.2820418056, 45078.2835258565, 8.36, 25, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45078.2820418056, 4.18, 4182.25, 'true', 2),
((select id from t_id), (select id from i_id), 45078.2835258218, 2.09, 4182.5, 'false', 1),
((select id from t_id), (select id from i_id), 45078.2835258565, 2.09, 4182.5, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-07!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45078.2940812731, 45078.2941774306, 8.36, 100, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45078.2940812731, 4.18, 4186.5, 'true', 2),
((select id from t_id), (select id from i_id), 45078.2941773727, 2.09, 4187.5, 'false', 1),
((select id from t_id), (select id from i_id), 45078.2941774306, 2.09, 4187.5, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-07!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45078.2997791551, 45078.3004451505, 8.36, -200, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45078.2997791551, 2.09, 4191.75, 'false', 1),
((select id from t_id), (select id from i_id), 45078.2997791898, 2.09, 4191.75, 'false', 1),
((select id from t_id), (select id from i_id), 45078.3004451042, 2.09, 4193.75, 'true', 1),
((select id from t_id), (select id from i_id), 45078.3004451505, 2.09, 4193.75, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-07!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45078.3010043287, 45078.3021919213, 8.36, 125, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45078.3010043287, 4.18, 4194.25, 'true', 2),
((select id from t_id), (select id from i_id), 45078.3020764352, 2.09, 4195.5, 'false', 1),
((select id from t_id), (select id from i_id), 45078.3021919213, 2.09, 4195.5, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-07!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45078.3376705556, 45078.3378318403, 8.36, 0, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45078.3376705556, 4.18, 4204.5, 'false', 2),
((select id from t_id), (select id from i_id), 45078.3378318287, 2.09, 4204.5, 'true', 1),
((select id from t_id), (select id from i_id), 45078.3378318403, 2.09, 4204.5, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-07!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45078.337968588, 45078.3420350231, 8.36, 137.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45078.337968588, 4.18, 4204.5, 'true', 2),
((select id from t_id), (select id from i_id), 45078.3419844213, 2.09, 4205.5, 'false', 1),
((select id from t_id), (select id from i_id), 45078.3420350231, 2.09, 4206.25, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-07!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45082.2729404745, 45082.2734895139, 8.36, 100, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45082.2729404745, 4.18, 4293.75, 'true', 2),
((select id from t_id), (select id from i_id), 45082.2731097338, 2.09, 4294.75, 'false', 1),
((select id from t_id), (select id from i_id), 45082.2734895139, 2.09, 4294.75, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-07!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45082.2793347454, 45082.2803025463, 8.36, 100, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45082.2793347454, 4.18, 4298.75, 'true', 2),
((select id from t_id), (select id from i_id), 45082.280297963, 2.09, 4299.75, 'false', 1),
((select id from t_id), (select id from i_id), 45082.2803025463, 2.09, 4299.75, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-07!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45084.2724226852, 45084.272833287, 8.36, 137.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45084.2724226852, 4.18, 4294.5, 'true', 2),
((select id from t_id), (select id from i_id), 45084.2727124306, 2.09, 4296, 'false', 1),
((select id from t_id), (select id from i_id), 45084.272833287, 2.09, 4295.75, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-07!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45085.2789472685, 45085.2813044329, 8.36, 200, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45085.2789472685, 4.18, 4273.75, 'false', 2),
((select id from t_id), (select id from i_id), 45085.2813043982, 2.09, 4271.75, 'true', 1),
((select id from t_id), (select id from i_id), 45085.2813044329, 2.09, 4271.75, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-07!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45086.3231731944, 45086.3241829167, 8.36, -200, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45086.3231731944, 4.18, 4316.25, 'false', 2),
((select id from t_id), (select id from i_id), 45086.3241829051, 2.09, 4318.25, 'true', 1),
((select id from t_id), (select id from i_id), 45086.3241829167, 2.09, 4318.25, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-07!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45086.3242306134, 45086.3245788542, 8.36, -225, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45086.3242306134, 4.18, 4318.75, 'false', 2),
((select id from t_id), (select id from i_id), 45086.3245788542, 4.18, 4321, 'true', 2);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-07!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45086.3246488079, 45086.3264483565, 41.8, -2350, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45086.3246488079, 4.18, 4321.75, 'true', 2),
((select id from t_id), (select id from i_id), 45086.3253358449, 8.36, 4320, 'true', 4),
((select id from t_id), (select id from i_id), 45086.3263542593, 2.09, 4316.5, 'true', 1),
((select id from t_id), (select id from i_id), 45086.3263542708, 6.27, 4316.5, 'true', 3),
((select id from t_id), (select id from i_id), 45086.3264483565, 20.9, 4314.25, 'false', 10);


insert into accounts (user_id, name, sim)
values ('6982c6df-3d03-4583-8fa9-07386cf25f80', 'PA-APEX-30411-03!Apex!Apex', false)
on conflict ("name") do nothing;

insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-03!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45148.2977003704, 45148.2977689815, 0, 50, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45148.2977003704, 0, 4539.75, 'true', 1),
((select id from t_id), (select id from i_id), 45148.2977689815, 0, 4540.75, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-03!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45148.3466316782, 45148.3473721991, 0, 50, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45148.3466316782, 0, 4511.25, 'false', 1),
((select id from t_id), (select id from i_id), 45148.3473721991, 0, 4510.25, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-03!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45148.353168912, 45148.3540065857, 0, -225, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45148.353168912, 0, 4512.75, 'false', 1),
((select id from t_id), (select id from i_id), 45148.3535263426, 0, 4513.75, 'false', 1),
((select id from t_id), (select id from i_id), 45148.3540065857, 0, 4515.5, 'true', 2);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-03!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45148.3541845486, 45148.355354838, 0, 12.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45148.3541845486, 0, 4515, 'false', 1),
((select id from t_id), (select id from i_id), 45148.355354838, 0, 4514.75, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-03!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45148.355665625, 45148.3576083912, 0, 287.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45148.355665625, 0, 4513.75, 'true', 1),
((select id from t_id), (select id from i_id), 45148.3576083912, 0, 4519.5, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-03!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45149.270930463, 45149.2716587731, 0, 100, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45149.270930463, 0, 4465.5, 'false', 1),
((select id from t_id), (select id from i_id), 45149.2716587731, 0, 4463.5, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-03!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45149.2824860648, 45149.2858437384, 12.54, 150, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45149.2824860648, 2.09, 4462.75, 'false', 1),
((select id from t_id), (select id from i_id), 45149.2828219329, 2.09, 4464.5, 'false', 1),
((select id from t_id), (select id from i_id), 45149.2841944907, 2.09, 4466.25, 'false', 1),
((select id from t_id), (select id from i_id), 45149.2858437037, 2.09, 4463.5, 'true', 1),
((select id from t_id), (select id from i_id), 45149.2858437384, 4.18, 4463.5, 'true', 2);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-03!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45152.2746565162, 45152.2750100116, 8.36, -175, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45152.2746565162, 2.09, 4474.75, 'true', 1),
((select id from t_id), (select id from i_id), 45152.2749828009, 2.09, 4473.25, 'true', 1),
((select id from t_id), (select id from i_id), 45152.2750099769, 2.09, 4472.25, 'false', 1),
((select id from t_id), (select id from i_id), 45152.2750100116, 2.09, 4472.25, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-03!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45152.2751891782, 45152.2757565856, 4.18, -100, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45152.2751891782, 2.09, 4472.25, 'true', 1),
((select id from t_id), (select id from i_id), 45152.2757565856, 2.09, 4470.25, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-03!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45152.2760235648, 45152.2800205556, 4.18, 262.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45152.2760235648, 2.09, 4471.5, 'true', 1),
((select id from t_id), (select id from i_id), 45152.2800205556, 2.09, 4476.75, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-03!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45152.2848836806, 45152.285210787, 4.18, -100, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45152.2848836806, 2.09, 4470.25, 'false', 1),
((select id from t_id), (select id from i_id), 45152.285210787, 2.09, 4472.25, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-03!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45152.2876257755, 45152.2885158218, 4.18, -100, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45152.2876257755, 2.09, 4475.75, 'true', 1),
((select id from t_id), (select id from i_id), 45152.2885158218, 2.09, 4473.75, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-03!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45152.2886700926, 45152.2903965046, 8.36, 150, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45152.2886700926, 2.09, 4474, 'true', 1),
((select id from t_id), (select id from i_id), 45152.2899776968, 2.09, 4475, 'true', 1),
((select id from t_id), (select id from i_id), 45152.2903959144, 2.09, 4476, 'false', 1),
((select id from t_id), (select id from i_id), 45152.2903965046, 2.09, 4476, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-03!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45152.3145656713, 45152.315129213, 4.18, 50, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45152.3145656713, 2.09, 4486, 'true', 1),
((select id from t_id), (select id from i_id), 45152.315129213, 2.09, 4487, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-03!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45152.3366284722, 45152.3375334954, 4.18, 62.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45152.3366284722, 2.09, 4495.5, 'false', 1),
((select id from t_id), (select id from i_id), 45152.3375334954, 2.09, 4494.25, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-03!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45152.536720787, 45152.5375173264, 4.18, 50, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45152.536720787, 2.09, 4497.5, 'true', 1),
((select id from t_id), (select id from i_id), 45152.5375173264, 2.09, 4498.5, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-03!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45153.2460461227, 45153.2476400116, 4.18, 50, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45153.2460461227, 2.09, 4475.75, 'true', 1),
((select id from t_id), (select id from i_id), 45153.2476400116, 2.09, 4476.75, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-03!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45153.2765245949, 45153.2766767824, 4.18, 62.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45153.2765245949, 2.09, 4486.5, 'true', 1),
((select id from t_id), (select id from i_id), 45153.2766767824, 2.09, 4487.75, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-03!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45154.2887331134, 45154.2892671991, 4.18, 12.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45154.2887331134, 2.09, 4458.5, 'false', 1),
((select id from t_id), (select id from i_id), 45154.2892671991, 2.09, 4458.25, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-03!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45154.2908248264, 45154.2910752894, 4.18, 12.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45154.2908248264, 2.09, 4460, 'false', 1),
((select id from t_id), (select id from i_id), 45154.2910752894, 2.09, 4459.75, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-03!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45154.3130645602, 45154.313173287, 4.18, 25, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45154.3130645602, 2.09, 4458, 'true', 1),
((select id from t_id), (select id from i_id), 45154.313173287, 2.09, 4458.5, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-03!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45155.2599210301, 45155.2710275347, 4.18, 50, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45155.2599210301, 2.09, 4433, 'true', 1),
((select id from t_id), (select id from i_id), 45155.2710275347, 2.09, 4434, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-03!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45155.2826205787, 45155.2830533333, 4.18, 12.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45155.2826205787, 2.09, 4426, 'true', 1),
((select id from t_id), (select id from i_id), 45155.2830533333, 2.09, 4426.25, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-03!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45155.2886056134, 45155.2888528125, 4.18, 12.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45155.2886056134, 2.09, 4421, 'false', 1),
((select id from t_id), (select id from i_id), 45155.2888528125, 2.09, 4420.75, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-03!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45155.291363125, 45155.2922297685, 4.18, -100, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45155.291363125, 2.09, 4425, 'false', 1),
((select id from t_id), (select id from i_id), 45155.2922297685, 2.09, 4427, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-03!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45155.2928885995, 45155.2945127662, 8.36, 100, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45155.2928885995, 2.09, 4426.5, 'true', 1),
((select id from t_id), (select id from i_id), 45155.2938846412, 2.09, 4424.5, 'true', 1),
((select id from t_id), (select id from i_id), 45155.2945127546, 2.09, 4426.5, 'false', 1),
((select id from t_id), (select id from i_id), 45155.2945127662, 2.09, 4426.5, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-03!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45155.2991428009, 45155.2993441898, 4.18, -100, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45155.2991428009, 2.09, 4427, 'true', 1),
((select id from t_id), (select id from i_id), 45155.2993441898, 2.09, 4425, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-03!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45155.2995757523, 45155.3004129977, 4.18, -100, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45155.2995757523, 2.09, 4426.25, 'true', 1),
((select id from t_id), (select id from i_id), 45155.3004129977, 2.09, 4424.25, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-03!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45155.300617963, 45155.3012307523, 8.36, -162.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45155.300617963, 2.09, 4423.75, 'true', 1),
((select id from t_id), (select id from i_id), 45155.3011553472, 2.09, 4422, 'true', 1),
((select id from t_id), (select id from i_id), 45155.3012307523, 4.18, 4421.25, 'false', 2);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-03!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45155.3014698032, 45155.3021577778, 8.36, -200, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45155.3014698032, 2.09, 4421, 'false', 1),
((select id from t_id), (select id from i_id), 45155.3021459028, 2.09, 4424, 'false', 1),
((select id from t_id), (select id from i_id), 45155.3021575116, 2.09, 4424.5, 'true', 1),
((select id from t_id), (select id from i_id), 45155.3021577778, 2.09, 4424.5, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-03!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45155.3022182986, 45155.3027562732, 8.36, 275, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45155.3022182986, 2.09, 4424, 'true', 1),
((select id from t_id), (select id from i_id), 45155.3023634375, 2.09, 4424, 'true', 1),
((select id from t_id), (select id from i_id), 45155.30275625, 2.09, 4426.75, 'false', 1),
((select id from t_id), (select id from i_id), 45155.3027562732, 2.09, 4426.75, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-03!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45159.2737576157, 45159.2739619907, 4.18, 87.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45159.2737576157, 2.09, 4396.5, 'true', 1),
((select id from t_id), (select id from i_id), 45159.2739619907, 2.09, 4398.25, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-03!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45159.2840618519, 45159.2845675694, 4.18, 50, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45159.2840618519, 2.09, 4397, 'true', 1),
((select id from t_id), (select id from i_id), 45159.2845675694, 2.09, 4398, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-03!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45159.3058902431, 45159.3061832755, 4.18, 25, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45159.3058902431, 2.09, 4395.75, 'true', 1),
((select id from t_id), (select id from i_id), 45159.3061832755, 2.09, 4396.25, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-03!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45160.2756916782, 45160.2763206134, 4.18, 62.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45160.2756916782, 2.09, 4426.25, 'false', 1),
((select id from t_id), (select id from i_id), 45160.2763206134, 2.09, 4425, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-03!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45160.2816376968, 45160.2820398958, 4.18, 50, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45160.2816376968, 2.09, 4423, 'false', 1),
((select id from t_id), (select id from i_id), 45160.2820398958, 2.09, 4422, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-03!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45160.3094652431, 45160.3100010185, 4.18, -100, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45160.3094652431, 2.09, 4416.5, 'true', 1),
((select id from t_id), (select id from i_id), 45160.3100010185, 2.09, 4414.5, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-03!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45160.3254987963, 45160.3280096296, 4.18, -62.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45160.3254987963, 2.09, 4411.25, 'false', 1),
((select id from t_id), (select id from i_id), 45160.3280096296, 2.09, 4412.5, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-03!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45160.3376434722, 45160.3380251389, 4.18, 62.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45160.3376434722, 2.09, 4411.25, 'true', 1),
((select id from t_id), (select id from i_id), 45160.3380251389, 2.09, 4412.5, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-03!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45161.2423339931, 45161.2465384722, 4.18, 137.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45161.2423339931, 2.09, 4405, 'false', 1),
((select id from t_id), (select id from i_id), 45161.2465384722, 2.09, 4402.25, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-03!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45162.2400791435, 45162.2407016667, 4.18, 112.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45162.2400791435, 2.09, 4465, 'true', 1),
((select id from t_id), (select id from i_id), 45162.2407016667, 2.09, 4467.25, 'false', 1);


insert into accounts (user_id, name, sim)
values ('6982c6df-3d03-4583-8fa9-07386cf25f80', 'PA-APEX-30411-01!Apex!Apex', false)
on conflict ("name") do nothing;

insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 44999.2894728704, 44999.2896268171, 1.12, 10, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 44999.2894728704, 0.56, 3942, 'true', 1),
((select id from t_id), (select id from i_id), 44999.2896268171, 0.56, 3944, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 44999.3070770255, 44999.307384294, 1.12, -11.25, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 44999.3070770255, 0.56, 3955.75, 'false', 1),
((select id from t_id), (select id from i_id), 44999.307384294, 0.56, 3958, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 44999.3079813773, 44999.3103119792, 1.12, 5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 44999.3079813773, 0.56, 3958, 'false', 1),
((select id from t_id), (select id from i_id), 44999.3103119792, 0.56, 3957, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 44999.3334241898, 44999.3344369676, 1.12, 7.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 44999.3334241898, 0.56, 3958.75, 'true', 1),
((select id from t_id), (select id from i_id), 44999.3344369676, 0.56, 3960.25, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45000.2923301389, 45000.2933455671, 2.24, 48.75, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45000.2923301389, 0.56, 3889, 'true', 1),
((select id from t_id), (select id from i_id), 45000.2928876157, 0.56, 3884.75, 'true', 1),
((select id from t_id), (select id from i_id), 45000.2933446759, 0.56, 3891.75, 'false', 1),
((select id from t_id), (select id from i_id), 45000.2933455671, 0.56, 3891.75, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45001.4287143866, 45001.4305376852, 1.12, 6.25, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45001.4287143866, 0.56, 3982, 'true', 1),
((select id from t_id), (select id from i_id), 45001.4305376852, 0.56, 3983.25, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45002.2815532176, 45002.2858166088, 2.24, 17.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45002.2815532176, 0.56, 3977, 'true', 1),
((select id from t_id), (select id from i_id), 45002.2842982176, 0.56, 3972.5, 'true', 1),
((select id from t_id), (select id from i_id), 45002.2858166088, 1.12, 3976.5, 'false', 2);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45002.290020162, 45002.2904652778, 1.12, 6.25, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45002.290020162, 0.56, 3977.5, 'false', 1),
((select id from t_id), (select id from i_id), 45002.2904652778, 0.56, 3976.25, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45002.2998383796, 45002.3268311574, 4.48, -400, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45002.2998383796, 0.56, 3977.5, 'true', 1),
((select id from t_id), (select id from i_id), 45002.3042962731, 0.56, 3972.75, 'true', 1),
((select id from t_id), (select id from i_id), 45002.3051608333, 0.56, 3967, 'true', 1),
((select id from t_id), (select id from i_id), 45002.3089579167, 0.56, 3960.75, 'true', 1),
((select id from t_id), (select id from i_id), 45002.3268311574, 2.24, 3949.5, 'false', 4);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45005.2669307523, 45005.2709251042, 1.22, 10, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45005.2669307523, 0.61, 3954.5, 'true', 1),
((select id from t_id), (select id from i_id), 45005.2709251042, 0.61, 3956.5, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45005.2717371296, 45005.2740734144, 2.44, 8.75, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45005.2717371296, 0.61, 3953, 'false', 1),
((select id from t_id), (select id from i_id), 45005.2731026852, 0.61, 3961.75, 'false', 1),
((select id from t_id), (select id from i_id), 45005.2740734144, 1.22, 3956.5, 'true', 2);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45005.2817153819, 45005.2822903125, 1.22, 20, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45005.2817153819, 0.61, 3957.75, 'false', 1),
((select id from t_id), (select id from i_id), 45005.2822903125, 0.61, 3953.75, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45005.2903596296, 45005.291085463, 1.22, 10, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45005.2903596296, 0.61, 3965.5, 'false', 1),
((select id from t_id), (select id from i_id), 45005.291085463, 0.61, 3963.5, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45005.2991106597, 45005.2993795718, 1.22, 6.25, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45005.2991106597, 0.61, 3962.75, 'true', 1),
((select id from t_id), (select id from i_id), 45005.2993795718, 0.61, 3964, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45005.3028639236, 45005.3032309838, 1.22, 2.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45005.3028639236, 0.61, 3966.25, 'true', 1),
((select id from t_id), (select id from i_id), 45005.3032309838, 0.61, 3966.75, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45006.2887450116, 45006.2905054514, 1.22, -6.25, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45006.2887450116, 0.61, 4024.25, 'false', 1),
((select id from t_id), (select id from i_id), 45006.2905054514, 0.61, 4025.5, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45006.2950323727, 45006.2957475, 1.22, 10, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45006.2950323727, 0.61, 4023, 'false', 1),
((select id from t_id), (select id from i_id), 45006.2957475, 0.61, 4021, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45006.3158802431, 45006.3168117824, 1.22, -10, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45006.3158802431, 0.61, 4010, 'true', 1),
((select id from t_id), (select id from i_id), 45006.3168117824, 0.61, 4008, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45006.3279012384, 45006.3296961574, 1.22, 1.25, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45006.3279012384, 0.61, 4009.75, 'true', 1),
((select id from t_id), (select id from i_id), 45006.3296961574, 0.61, 4010, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45006.3515976273, 45006.3519399884, 1.22, 16.25, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45006.3515976273, 0.61, 4019.25, 'false', 1),
((select id from t_id), (select id from i_id), 45006.3519399884, 0.61, 4016, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45007.3079113079, 45007.3105552662, 1.22, -11.25, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45007.3079113079, 0.61, 4039.5, 'false', 1),
((select id from t_id), (select id from i_id), 45007.3105552662, 0.61, 4041.75, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45007.3152387268, 45007.3206087153, 1.22, 3.75, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45007.3152387268, 0.61, 4044.25, 'false', 1),
((select id from t_id), (select id from i_id), 45007.3206087153, 0.61, 4043.5, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45007.3433379398, 45007.3439625116, 1.22, 5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45007.3433379398, 0.61, 4035, 'true', 1),
((select id from t_id), (select id from i_id), 45007.3439625116, 0.61, 4036, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45007.4182908912, 45007.4212317014, 1.22, -11.25, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45007.4182908912, 0.61, 4024.75, 'true', 1),
((select id from t_id), (select id from i_id), 45007.4212317014, 0.61, 4022.5, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45007.4614573032, 45007.4619141204, 1.22, -25, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45007.4614573032, 0.61, 4050.25, 'false', 1),
((select id from t_id), (select id from i_id), 45007.4619141204, 0.61, 4055.25, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45007.46251375, 45007.4625607407, 1.22, -12.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45007.46251375, 0.61, 4058.5, 'false', 1),
((select id from t_id), (select id from i_id), 45007.4625607407, 0.61, 4061, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45007.4627704167, 45007.4632565856, 1.22, 27.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45007.4627704167, 0.61, 4064.75, 'false', 1),
((select id from t_id), (select id from i_id), 45007.4632565856, 0.61, 4059.25, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45007.4640017245, 45007.4641701157, 1.22, 6.25, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45007.4640017245, 0.61, 4054.75, 'true', 1),
((select id from t_id), (select id from i_id), 45007.4641701157, 0.61, 4056, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45007.4646874537, 45007.4664195255, 2.44, -60, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45007.4646874537, 0.61, 4052.25, 'true', 1),
((select id from t_id), (select id from i_id), 45007.4663095718, 0.61, 4048.75, 'true', 1),
((select id from t_id), (select id from i_id), 45007.4664195255, 1.22, 4044.5, 'false', 2);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45007.4679835648, 45007.4679925116, 1.22, -1.25, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45007.4679835648, 0.61, 4038.75, 'false', 1),
((select id from t_id), (select id from i_id), 45007.4679925116, 0.61, 4039, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45008.2850027662, 45008.2853019907, 1.22, 10, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45008.2850027662, 0.61, 4005.75, 'false', 1),
((select id from t_id), (select id from i_id), 45008.2853019907, 0.61, 4003.75, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45008.3009028241, 45008.3018540625, 1.22, 7.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45008.3009028241, 0.61, 4012.25, 'true', 1),
((select id from t_id), (select id from i_id), 45008.3018540625, 0.61, 4013.75, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45008.3071954167, 45008.3072578009, 1.22, 3.75, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45008.3071954167, 0.61, 4010.25, 'true', 1),
((select id from t_id), (select id from i_id), 45008.3072578009, 0.61, 4011, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45008.3166653241, 45008.3169736111, 1.22, -10, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45008.3166653241, 0.61, 4012.25, 'true', 1),
((select id from t_id), (select id from i_id), 45008.3169736111, 0.61, 4010.25, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45008.3174506829, 45008.3183903472, 1.22, 5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45008.3174506829, 0.61, 4011.5, 'true', 1),
((select id from t_id), (select id from i_id), 45008.3183903472, 0.61, 4012.5, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45008.3222712384, 45008.3224347917, 1.22, 5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45008.3222712384, 0.61, 4017.75, 'false', 1),
((select id from t_id), (select id from i_id), 45008.3224347917, 0.61, 4016.75, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45009.24863, 45009.2505709375, 1.22, 10, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45009.24863, 0.61, 3955.5, 'false', 1),
((select id from t_id), (select id from i_id), 45009.2505709375, 0.61, 3953.5, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45009.2739253241, 45009.2741835069, 1.22, 5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45009.2739253241, 0.61, 3955.75, 'true', 1),
((select id from t_id), (select id from i_id), 45009.2741835069, 0.61, 3956.75, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45009.3224155208, 45009.3232572569, 1.22, 10, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45009.3224155208, 0.61, 3956, 'true', 1),
((select id from t_id), (select id from i_id), 45009.3232572569, 0.61, 3958, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45012.2709516319, 45012.2713721065, 1.22, 10, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45012.2709516319, 0.61, 4026.75, 'false', 1),
((select id from t_id), (select id from i_id), 45012.2713721065, 0.61, 4024.75, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45012.3111002546, 45012.3154716551, 2.44, -52.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45012.3111002546, 0.61, 4019.25, 'true', 1),
((select id from t_id), (select id from i_id), 45012.3131448264, 0.61, 4012.25, 'true', 1),
((select id from t_id), (select id from i_id), 45012.3154714236, 0.61, 4010.5, 'false', 1),
((select id from t_id), (select id from i_id), 45012.3154716551, 0.61, 4010.5, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45012.3189329514, 45012.324291088, 2.44, 22.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45012.3189329514, 0.61, 4011.75, 'true', 1),
((select id from t_id), (select id from i_id), 45012.3230717014, 0.61, 4008.25, 'true', 1),
((select id from t_id), (select id from i_id), 45012.324291088, 1.22, 4012.25, 'false', 2);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45012.3248550579, 45012.3252376389, 1.22, 15, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45012.3248550579, 0.61, 4013.25, 'false', 1),
((select id from t_id), (select id from i_id), 45012.3252376389, 0.61, 4010.25, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45012.3337735185, 45012.3354159722, 2.44, 10, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45012.3337735185, 0.61, 4009.25, 'true', 1),
((select id from t_id), (select id from i_id), 45012.3351073495, 0.61, 4007.25, 'true', 1),
((select id from t_id), (select id from i_id), 45012.3354158912, 0.61, 4009.25, 'false', 1),
((select id from t_id), (select id from i_id), 45012.3354159722, 0.61, 4009.25, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45012.4671952662, 45012.4762023958, 3.66, -72.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45012.4671952662, 0.61, 4012.5, 'false', 1),
((select id from t_id), (select id from i_id), 45012.4704905556, 0.61, 4015.25, 'false', 1),
((select id from t_id), (select id from i_id), 45012.4737839468, 0.61, 4017.75, 'false', 1),
((select id from t_id), (select id from i_id), 45012.4762023958, 1.83, 4020, 'true', 3);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45013.2467640162, 45013.2484036921, 1.22, 5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45013.2467640162, 0.61, 3998.25, 'true', 1),
((select id from t_id), (select id from i_id), 45013.2484036921, 0.61, 3999.25, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45013.2716695023, 45013.2717998611, 1.22, 2.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45013.2716695023, 0.61, 3999, 'false', 1),
((select id from t_id), (select id from i_id), 45013.2717998611, 0.61, 3998.5, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45013.2724760301, 45013.2742562732, 4.88, 17.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45013.2724760301, 1.22, 3997.75, 'true', 2),
((select id from t_id), (select id from i_id), 45013.2735547222, 0.61, 3994.5, 'true', 1),
((select id from t_id), (select id from i_id), 45013.2735578704, 0.61, 3994.5, 'true', 1),
((select id from t_id), (select id from i_id), 45013.2739960532, 1.83, 3996.75, 'false', 3),
((select id from t_id), (select id from i_id), 45013.2742562732, 0.61, 3998.75, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45013.2746837731, 45013.2764536806, 2.44, 15, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45013.2746837731, 1.22, 3998.75, 'false', 2),
((select id from t_id), (select id from i_id), 45013.2756964583, 0.61, 3996.75, 'true', 1),
((select id from t_id), (select id from i_id), 45013.2764536806, 0.61, 3997.75, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45013.2777520255, 45013.2780881944, 1.22, 6.25, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45013.2777520255, 0.61, 3999.75, 'true', 1),
((select id from t_id), (select id from i_id), 45013.2780881944, 0.61, 4001, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45013.2806020833, 45013.2810858449, 1.22, 3.75, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45013.2806020833, 0.61, 4000.75, 'false', 1),
((select id from t_id), (select id from i_id), 45013.2810858449, 0.61, 4000, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45015.2772587037, 45015.2784897569, 1.22, 5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45015.2772587037, 0.61, 4080.25, 'true', 1),
((select id from t_id), (select id from i_id), 45015.2784897569, 0.61, 4081.25, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45015.2919181713, 45015.2923428472, 2.44, 10, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45015.2919181713, 1.22, 4086.25, 'false', 2),
((select id from t_id), (select id from i_id), 45015.292296169, 0.61, 4085.25, 'true', 1),
((select id from t_id), (select id from i_id), 45015.2923428472, 0.61, 4085.25, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45015.2954725116, 45015.3005597685, 2.44, -65, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45015.2954725116, 1.22, 4079.25, 'true', 2),
((select id from t_id), (select id from i_id), 45015.3005597685, 1.22, 4072.75, 'false', 2);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45015.300758125, 45015.3033270718, 2.44, 12.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45015.300758125, 1.22, 4073.75, 'false', 2),
((select id from t_id), (select id from i_id), 45015.3033270718, 1.22, 4072.5, 'true', 2);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45016.3032257986, 45016.3033503935, 2.44, 2.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45016.3032257986, 1.22, 4099, 'false', 2),
((select id from t_id), (select id from i_id), 45016.3033503935, 1.22, 4098.75, 'true', 2);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45016.3112994792, 45016.3119840162, 1.22, 5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45016.3112994792, 0.61, 4102.75, 'false', 1),
((select id from t_id), (select id from i_id), 45016.3119840162, 0.61, 4101.75, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45019.2725298495, 45019.2752385301, 4.88, -85, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45019.2725298495, 1.22, 4134.75, 'false', 2),
((select id from t_id), (select id from i_id), 45019.2745575116, 1.22, 4138.25, 'false', 2),
((select id from t_id), (select id from i_id), 45019.2752385185, 1.22, 4140.75, 'true', 2),
((select id from t_id), (select id from i_id), 45019.2752385301, 1.22, 4140.75, 'true', 2);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45019.2756066782, 45019.2775749769, 2.44, 5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45019.2756066782, 1.22, 4141.5, 'true', 2),
((select id from t_id), (select id from i_id), 45019.2775749653, 0.61, 4142, 'false', 1),
((select id from t_id), (select id from i_id), 45019.2775749769, 0.61, 4142, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 44973.272417338, 44973.2725554051, 6.88, -125, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 44973.272417338, 3.44, 4110.25, 'true', 1),
((select id from t_id), (select id from i_id), 44973.2725554051, 3.44, 4107.75, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 44973.2735518866, 44973.274094838, 6.88, -100, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 44973.2735518866, 3.44, 4109.5, 'true', 1),
((select id from t_id), (select id from i_id), 44973.274094838, 3.44, 4107.5, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 44973.274298206, 44973.2754561574, 6.88, 287.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 44973.274298206, 3.44, 4108, 'false', 1),
((select id from t_id), (select id from i_id), 44973.2754561574, 3.44, 4102.25, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 44973.2786560069, 44973.2793384606, 6.88, 87.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 44973.2786560069, 3.44, 4109.5, 'false', 1),
((select id from t_id), (select id from i_id), 44973.2793384606, 3.44, 4107.75, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 44978.2947595486, 44978.2953374884, 4.08, 62.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 44978.2947595486, 2.04, 4039, 'false', 1),
((select id from t_id), (select id from i_id), 44978.2953374884, 2.04, 4037.75, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 44978.3035445023, 44978.3036495949, 4.08, 25, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 44978.3035445023, 2.04, 4034.75, 'false', 1),
((select id from t_id), (select id from i_id), 44978.3036495949, 2.04, 4034.25, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 44978.3596436111, 44978.3599108449, 4.08, 50, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 44978.3596436111, 2.04, 4022.75, 'false', 1),
((select id from t_id), (select id from i_id), 44978.3599108449, 2.04, 4021.75, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 44984.2645127431, 44984.2668869676, 4.08, 62.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 44984.2645127431, 2.04, 4009.5, 'true', 1),
((select id from t_id), (select id from i_id), 44984.2668869676, 2.04, 4010.75, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 44984.2725966435, 44984.2727172338, 4.08, -100, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 44984.2725966435, 2.04, 4008.5, 'true', 1),
((select id from t_id), (select id from i_id), 44984.2727172338, 2.04, 4006.5, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 44984.273233125, 44984.2740239931, 4.08, -150, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 44984.273233125, 2.04, 4008.5, 'true', 1),
((select id from t_id), (select id from i_id), 44984.2740239931, 2.04, 4005.5, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 44984.2746316204, 44984.2762529398, 4.08, 62.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 44984.2746316204, 2.04, 4006, 'true', 1),
((select id from t_id), (select id from i_id), 44984.2762529398, 2.04, 4007.25, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 44984.2796986111, 44984.2801028009, 4.08, 50, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 44984.2796986111, 2.04, 4007.25, 'true', 1),
((select id from t_id), (select id from i_id), 44984.2801028009, 2.04, 4008.25, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 44984.2842684028, 44984.2850959954, 4.08, -100, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 44984.2842684028, 2.04, 4004.5, 'false', 1),
((select id from t_id), (select id from i_id), 44984.2850959954, 2.04, 4006.5, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 44984.2881555208, 44984.2887882639, 4.08, 100, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 44984.2881555208, 2.04, 4008.5, 'true', 1),
((select id from t_id), (select id from i_id), 44984.2887882639, 2.04, 4010.5, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 44984.3172248843, 44984.3173191782, 4.08, 25, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 44984.3172248843, 2.04, 4009.75, 'false', 1),
((select id from t_id), (select id from i_id), 44984.3173191782, 2.04, 4009.25, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 44984.321504294, 44984.3215832523, 4.08, 12.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 44984.321504294, 2.04, 4001.5, 'false', 1),
((select id from t_id), (select id from i_id), 44984.3215832523, 2.04, 4001.25, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 44984.3382146528, 44984.3416478472, 4.08, 25, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 44984.3382146528, 2.04, 4004.5, 'false', 1),
((select id from t_id), (select id from i_id), 44984.3416478472, 2.04, 4004, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 44985.2919514583, 44985.2920592361, 4.08, -100, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 44985.2919514583, 2.04, 3983.75, 'false', 1),
((select id from t_id), (select id from i_id), 44985.2920592361, 2.04, 3985.75, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 44985.3307519213, 44985.3312838079, 4.08, -100, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 44985.3307519213, 2.04, 3980, 'false', 1),
((select id from t_id), (select id from i_id), 44985.3312838079, 2.04, 3982, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 44985.3323514583, 44985.3336260532, 4.08, 162.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 44985.3323514583, 2.04, 3982.25, 'true', 1),
((select id from t_id), (select id from i_id), 44985.3336260532, 2.04, 3985.5, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 44985.3553157755, 44985.3571060764, 4.08, -100, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 44985.3553157755, 2.04, 3990.5, 'true', 1),
((select id from t_id), (select id from i_id), 44985.3571060764, 2.04, 3988.5, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45013.5382434491, 45013.5382888194, 4.18, 25, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45013.5382434491, 2.09, 3998.75, 'true', 1),
((select id from t_id), (select id from i_id), 45013.5382888194, 2.09, 3999.25, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45014.2961023264, 45014.2973701852, 4.18, 37.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45014.2961023264, 2.09, 4043.25, 'true', 1),
((select id from t_id), (select id from i_id), 45014.2973701852, 2.09, 4044, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45014.3168332176, 45014.3188290046, 8.36, -100, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45014.3168332176, 2.09, 4038, 'true', 1),
((select id from t_id), (select id from i_id), 45014.3181432292, 2.09, 4036, 'true', 1),
((select id from t_id), (select id from i_id), 45014.3188290046, 4.18, 4036, 'false', 2);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45015.3041418056, 45015.3042072106, 4.18, -50, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45015.3041418056, 2.09, 4073.5, 'true', 1),
((select id from t_id), (select id from i_id), 45015.3042072106, 2.09, 4072.5, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45015.41574875, 45015.4159315509, 4.18, 25, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45015.41574875, 2.09, 4069, 'false', 1),
((select id from t_id), (select id from i_id), 45015.4159315509, 2.09, 4068.5, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45015.4230441782, 45015.4255791204, 4.18, 25, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45015.4230441782, 2.09, 4069.5, 'true', 1),
((select id from t_id), (select id from i_id), 45015.4255791204, 2.09, 4070, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45015.4676283796, 45015.4676520718, 4.18, -25, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45015.4676283796, 2.09, 4069, 'false', 1),
((select id from t_id), (select id from i_id), 45015.4676520718, 2.09, 4069.5, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45016.2847937847, 45016.284854213, 4.18, 37.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45016.2847937847, 2.09, 4100.25, 'true', 1),
((select id from t_id), (select id from i_id), 45016.284854213, 2.09, 4101, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45016.2985438542, 45016.2990821644, 4.18, 25, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45016.2985438542, 2.09, 4099.5, 'true', 1),
((select id from t_id), (select id from i_id), 45016.2990821644, 2.09, 4100, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45019.2777918634, 45019.2778957639, 4.18, 25, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45019.2777918634, 2.09, 4142.25, 'true', 1),
((select id from t_id), (select id from i_id), 45019.2778957639, 2.09, 4142.75, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45019.2782534954, 45019.2782614815, 4.18, 0, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45019.2782534954, 2.09, 4141.75, 'true', 1),
((select id from t_id), (select id from i_id), 45019.2782614815, 2.09, 4141.75, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-01!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45020.2709746991, 45020.2725709838, 8.36, -412.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45020.2709746991, 2.09, 4160.75, 'true', 1),
((select id from t_id), (select id from i_id), 45020.2715076389, 2.09, 4159, 'true', 1),
((select id from t_id), (select id from i_id), 45020.2725709838, 4.18, 4155.75, 'false', 2);


insert into accounts (user_id, name, sim)
values ('6982c6df-3d03-4583-8fa9-07386cf25f80', 'APEX-30411-06!Apex!Apex', false)
on conflict ("name") do nothing;

insert into instruments (code, price_per_point)
values ('NQ', 20)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'NQ'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45008.3354986921, 45008.3355486458, 4.18, 30, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45008.3354986921, 2.09, 13003.25, 'false', 1),
((select id from t_id), (select id from i_id), 45008.3355486458, 2.09, 13001.75, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45007.466762581, 45007.4668329745, 4.18, 62.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45007.466762581, 2.09, 4047, 'true', 1),
((select id from t_id), (select id from i_id), 45007.4668329745, 2.09, 4048.25, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45007.4685857292, 45007.4687532407, 4.18, 37.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45007.4685857292, 2.09, 4040.25, 'true', 1),
((select id from t_id), (select id from i_id), 45007.4687532407, 2.09, 4041, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45007.4698585301, 45007.4700906019, 4.18, -100, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45007.4698585301, 2.09, 4040, 'false', 1),
((select id from t_id), (select id from i_id), 45007.4700906019, 2.09, 4042, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45008.3523616667, 45008.3537224306, 4.18, -125, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45008.3523616667, 2.09, 4029, 'true', 1),
((select id from t_id), (select id from i_id), 45008.3537224306, 2.09, 4026.5, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45009.3786487037, 45009.3790834606, 4.18, 12.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45009.3786487037, 2.09, 3973.5, 'true', 1),
((select id from t_id), (select id from i_id), 45009.3790834606, 2.09, 3973.75, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45009.5326229861, 45009.5331371991, 4.18, 37.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45009.5326229861, 2.09, 3994.5, 'false', 1),
((select id from t_id), (select id from i_id), 45009.5331371991, 2.09, 3993.75, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45013.3097354051, 45013.3099392824, 4.18, 25, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45013.3097354051, 2.09, 4002.75, 'true', 1),
((select id from t_id), (select id from i_id), 45013.3099392824, 2.09, 4003.25, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45013.3133165278, 45013.3134091782, 4.18, 25, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45013.3133165278, 2.09, 3999.75, 'true', 1),
((select id from t_id), (select id from i_id), 45013.3134091782, 2.09, 4000.25, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45013.3158733218, 45013.3160173611, 4.18, 37.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45013.3158733218, 2.09, 3990.25, 'true', 1),
((select id from t_id), (select id from i_id), 45013.3160173611, 2.09, 3991, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45013.325661331, 45013.3285058912, 4.18, 12.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45013.325661331, 2.09, 3994, 'true', 1),
((select id from t_id), (select id from i_id), 45013.3285058912, 2.09, 3994.25, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45013.4979187037, 45013.4982787847, 4.18, 25, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45013.4979187037, 2.09, 3990.75, 'true', 1),
((select id from t_id), (select id from i_id), 45013.4982787847, 2.09, 3991.25, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45013.5135315393, 45013.5146834259, 4.18, 25, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45013.5135315393, 2.09, 3993.25, 'true', 1),
((select id from t_id), (select id from i_id), 45013.5146834259, 2.09, 3993.75, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45013.5405364583, 45013.542476088, 4.18, -262.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45013.5405364583, 2.09, 3999.5, 'false', 1),
((select id from t_id), (select id from i_id), 45013.542476088, 2.09, 4004.75, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45014.2961031713, 45014.2973710185, 4.18, 37.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45014.2961031713, 2.09, 4043.25, 'true', 1),
((select id from t_id), (select id from i_id), 45014.2973710185, 2.09, 4044, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45014.316833206, 45014.3188290046, 8.36, -100, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45014.316833206, 2.09, 4038, 'true', 1),
((select id from t_id), (select id from i_id), 45014.3181432523, 2.09, 4036, 'true', 1),
((select id from t_id), (select id from i_id), 45014.3188290046, 4.18, 4036, 'false', 2);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45015.2942016435, 45015.2948458681, 8.36, -87.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45015.2942016435, 2.09, 4082.75, 'true', 1),
((select id from t_id), (select id from i_id), 45015.2948451852, 2.09, 4081.5, 'true', 1),
((select id from t_id), (select id from i_id), 45015.2948458681, 4.18, 4081.25, 'false', 2);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45015.3041430208, 45015.3042072106, 4.18, -50, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45015.3041430208, 2.09, 4073.5, 'true', 1),
((select id from t_id), (select id from i_id), 45015.3042072106, 2.09, 4072.5, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45015.3051151389, 45015.308922338, 16.72, -737.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45015.3051151389, 2.09, 4073.5, 'false', 1),
((select id from t_id), (select id from i_id), 45015.3052472801, 2.09, 4075.25, 'false', 1),
((select id from t_id), (select id from i_id), 45015.3055203704, 2.09, 4075.5, 'false', 1),
((select id from t_id), (select id from i_id), 45015.3063896412, 2.09, 4076, 'false', 1),
((select id from t_id), (select id from i_id), 45015.3089214352, 2.09, 4078.75, 'true', 1),
((select id from t_id), (select id from i_id), 45015.308922338, 6.27, 4078.75, 'true', 3);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45015.3092879282, 45015.3100735301, 8.36, 275, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45015.3092879282, 2.09, 4077.75, 'true', 1),
((select id from t_id), (select id from i_id), 45015.3096876852, 2.09, 4077.75, 'true', 1),
((select id from t_id), (select id from i_id), 45015.3100735069, 2.09, 4080.5, 'false', 1),
((select id from t_id), (select id from i_id), 45015.3100735301, 2.09, 4080.5, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45015.3108191319, 45015.3118726968, 16.72, 300, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45015.3108191319, 4.18, 4083.5, 'false', 2),
((select id from t_id), (select id from i_id), 45015.3115342014, 4.18, 4083.5, 'false', 2),
((select id from t_id), (select id from i_id), 45015.3118718287, 2.09, 4082, 'true', 1),
((select id from t_id), (select id from i_id), 45015.3118726968, 6.27, 4082, 'true', 3);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45015.3134230324, 45015.3147055324, 16.72, 175, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45015.3134230324, 4.18, 4084, 'false', 2),
((select id from t_id), (select id from i_id), 45015.3138005671, 4.18, 4084.25, 'false', 2),
((select id from t_id), (select id from i_id), 45015.3147055324, 8.36, 4083.25, 'true', 4);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45015.3148760417, 45015.3190181713, 33.44, 625, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45015.3148760417, 4.18, 4083.25, 'true', 2),
((select id from t_id), (select id from i_id), 45015.3158465278, 4.18, 4080.5, 'true', 2),
((select id from t_id), (select id from i_id), 45015.3160238657, 4.18, 4080.75, 'true', 2),
((select id from t_id), (select id from i_id), 45015.3162710417, 4.18, 4079.25, 'true', 2),
((select id from t_id), (select id from i_id), 45015.3190181597, 8.36, 4082.5, 'false', 4),
((select id from t_id), (select id from i_id), 45015.3190181713, 8.36, 4082.5, 'false', 4);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45015.3258195486, 45015.3265329745, 8.36, 125, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45015.3258195486, 4.18, 4081.75, 'false', 2),
((select id from t_id), (select id from i_id), 45015.3261645949, 2.09, 4080.75, 'true', 1),
((select id from t_id), (select id from i_id), 45015.3265329745, 2.09, 4080.25, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45015.4322507407, 45015.4324651736, 4.18, 37.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45015.4322507407, 2.09, 4069.5, 'true', 1),
((select id from t_id), (select id from i_id), 45015.4324651736, 2.09, 4070.25, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45015.4569449306, 45015.4658434954, 16.72, 62.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45015.4569449306, 2.09, 4065, 'false', 1),
((select id from t_id), (select id from i_id), 45015.4594679167, 2.09, 4068.25, 'false', 1),
((select id from t_id), (select id from i_id), 45015.4623181597, 4.18, 4069.5, 'false', 2),
((select id from t_id), (select id from i_id), 45015.4658434838, 4.18, 4067.75, 'true', 2),
((select id from t_id), (select id from i_id), 45015.4658434954, 4.18, 4067.75, 'true', 2);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45016.2818676389, 45016.2819727199, 8.36, -125, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45016.2818676389, 4.18, 4097.5, 'false', 2),
((select id from t_id), (select id from i_id), 45016.2819727199, 4.18, 4098.75, 'true', 2);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45016.2847937847, 45016.284854213, 4.18, 37.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45016.2847937847, 2.09, 4100.25, 'true', 1),
((select id from t_id), (select id from i_id), 45016.284854213, 2.09, 4101, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45016.2985446875, 45016.2990821065, 4.18, 25, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45016.2985446875, 2.09, 4099.5, 'true', 1),
((select id from t_id), (select id from i_id), 45016.2990821065, 2.09, 4100, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45019.270961875, 45019.2710195602, 4.18, 25, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45019.270961875, 2.09, 4133.25, 'true', 1),
((select id from t_id), (select id from i_id), 45019.2710195602, 2.09, 4133.75, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45019.2782534954, 45019.2786088889, 4.18, -25, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45019.2782534954, 2.09, 4141.75, 'true', 1),
((select id from t_id), (select id from i_id), 45019.2786088889, 2.09, 4141.25, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45020.2709768982, 45020.2755217361, 12.54, 100, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45020.2709768982, 2.09, 4160.75, 'true', 1),
((select id from t_id), (select id from i_id), 45020.2715076389, 2.09, 4159, 'true', 1),
((select id from t_id), (select id from i_id), 45020.273168588, 2.09, 4156.25, 'true', 1),
((select id from t_id), (select id from i_id), 45020.2754943056, 2.09, 4159.5, 'false', 1),
((select id from t_id), (select id from i_id), 45020.2755217361, 4.18, 4159.25, 'false', 2);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45020.2784016435, 45020.2851335185, 8.36, 50, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45020.2784016435, 2.09, 4152.75, 'false', 1),
((select id from t_id), (select id from i_id), 45020.2848562037, 2.09, 4153.25, 'false', 1),
((select id from t_id), (select id from i_id), 45020.2851335069, 2.09, 4152.5, 'true', 1),
((select id from t_id), (select id from i_id), 45020.2851335185, 2.09, 4152.5, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45020.2858921528, 45020.2863991435, 4.18, 25, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45020.2858921528, 2.09, 4153, 'true', 1),
((select id from t_id), (select id from i_id), 45020.2863991435, 2.09, 4153.5, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45020.2868099306, 45020.2892875116, 4.18, -162.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45020.2868099306, 2.09, 4151.75, 'false', 1),
((select id from t_id), (select id from i_id), 45020.2892875116, 2.09, 4155, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45020.2895626042, 45020.2921807523, 4.18, 212.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45020.2895626042, 2.09, 4154, 'true', 1),
((select id from t_id), (select id from i_id), 45020.2921807523, 2.09, 4158.25, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45020.2960633102, 45020.2962288542, 4.18, 37.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45020.2960633102, 2.09, 4158.75, 'false', 1),
((select id from t_id), (select id from i_id), 45020.2962288542, 2.09, 4158, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45020.3004987616, 45020.3026469907, 4.18, 75, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45020.3004987616, 2.09, 4158.25, 'true', 1),
((select id from t_id), (select id from i_id), 45020.3026469907, 2.09, 4159.75, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45020.3069610532, 45020.3077001505, 8.36, 87.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45020.3069610532, 4.18, 4148.25, 'false', 2),
((select id from t_id), (select id from i_id), 45020.3076990741, 2.09, 4147.5, 'true', 1),
((select id from t_id), (select id from i_id), 45020.3077001505, 2.09, 4147.25, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45020.3098411921, 45020.3101093981, 4.18, 100, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45020.3098411921, 2.09, 4148.5, 'false', 1),
((select id from t_id), (select id from i_id), 45020.3101093981, 2.09, 4146.5, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45020.3141873843, 45020.3188675347, 41.8, 1125, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45020.3141873843, 4.18, 4152, 'false', 2),
((select id from t_id), (select id from i_id), 45020.3141873958, 6.27, 4152, 'false', 3),
((select id from t_id), (select id from i_id), 45020.3149517708, 10.45, 4152.5, 'false', 5),
((select id from t_id), (select id from i_id), 45020.3188675347, 20.9, 4150, 'true', 10);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45020.4123398264, 45020.4173750694, 16.72, 387.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45020.4123398264, 2.09, 4124.25, 'false', 1),
((select id from t_id), (select id from i_id), 45020.4157539931, 6.27, 4127.5, 'false', 3),
((select id from t_id), (select id from i_id), 45020.4173748148, 2.09, 4124.75, 'true', 1),
((select id from t_id), (select id from i_id), 45020.4173750694, 6.27, 4124.75, 'true', 3);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45020.4205443056, 45020.4213496065, 4.18, 100, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45020.4205443056, 2.09, 4127.5, 'true', 1),
((select id from t_id), (select id from i_id), 45020.4213496065, 2.09, 4129.5, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45020.4234430208, 45020.4237733796, 4.18, 112.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45020.4234430208, 2.09, 4128.75, 'false', 1),
((select id from t_id), (select id from i_id), 45020.4237733796, 2.09, 4126.5, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45020.4291142708, 45020.4340302778, 4.18, -112.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45020.4291142708, 2.09, 4132, 'false', 1),
((select id from t_id), (select id from i_id), 45020.4340302778, 2.09, 4134.25, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45020.4377073495, 45020.4388044444, 4.18, -37.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45020.4377073495, 2.09, 4133.25, 'false', 1),
((select id from t_id), (select id from i_id), 45020.4388044444, 2.09, 4134, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45020.4396145833, 45020.474592662, 41.8, -2200, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45020.4396145833, 4.18, 4134.25, 'true', 2),
((select id from t_id), (select id from i_id), 45020.4405393056, 4.18, 4132.75, 'true', 2),
((select id from t_id), (select id from i_id), 45020.4472832523, 8.36, 4131, 'true', 4),
((select id from t_id), (select id from i_id), 45020.4484979398, 4.18, 4129.25, 'true', 2),
((select id from t_id), (select id from i_id), 45020.474592662, 20.9, 4127.25, 'false', 10);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 44999.2894729167, 44999.2896279861, 1.12, 10, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 44999.2894729167, 0.56, 3942, 'true', 1),
((select id from t_id), (select id from i_id), 44999.2896279861, 0.56, 3944, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 44999.3070770255, 44999.3073844907, 1.12, -11.25, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 44999.3070770255, 0.56, 3955.75, 'false', 1),
((select id from t_id), (select id from i_id), 44999.3073844907, 0.56, 3958, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 44999.307981412, 44999.310312037, 1.12, 5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 44999.307981412, 0.56, 3958, 'false', 1),
((select id from t_id), (select id from i_id), 44999.310312037, 0.56, 3957, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 44999.3334241782, 44999.3344377894, 1.12, 7.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 44999.3334241782, 0.56, 3958.75, 'true', 1),
((select id from t_id), (select id from i_id), 44999.3344377894, 0.56, 3960.25, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45000.2923304398, 45000.2933458449, 2.24, 46.25, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45000.2923304398, 0.56, 3888.75, 'true', 1),
((select id from t_id), (select id from i_id), 45000.2928886343, 0.56, 3884.75, 'true', 1),
((select id from t_id), (select id from i_id), 45000.2933455093, 0.56, 3891.5, 'false', 1),
((select id from t_id), (select id from i_id), 45000.2933458449, 0.56, 3891.25, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45001.4287152778, 45001.4305376852, 1.12, 6.25, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45001.4287152778, 0.56, 3982, 'true', 1),
((select id from t_id), (select id from i_id), 45001.4305376852, 0.56, 3983.25, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45002.2815531713, 45002.2858166088, 2.24, 17.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45002.2815531713, 0.56, 3977, 'true', 1),
((select id from t_id), (select id from i_id), 45002.2842982176, 0.56, 3972.5, 'true', 1),
((select id from t_id), (select id from i_id), 45002.2858166088, 1.12, 3976.5, 'false', 2);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45002.290020162, 45002.2904660764, 1.12, 6.25, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45002.290020162, 0.56, 3977.5, 'false', 1),
((select id from t_id), (select id from i_id), 45002.2904660764, 0.56, 3976.25, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45002.2998391551, 45002.3268311574, 4.48, -400, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45002.2998391551, 0.56, 3977.5, 'true', 1),
((select id from t_id), (select id from i_id), 45002.3042970833, 0.56, 3972.75, 'true', 1),
((select id from t_id), (select id from i_id), 45002.3051608333, 0.56, 3967, 'true', 1),
((select id from t_id), (select id from i_id), 45002.308958831, 0.56, 3960.75, 'true', 1),
((select id from t_id), (select id from i_id), 45002.3268311574, 2.24, 3949.5, 'false', 4);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45005.2669307523, 45005.2709251042, 1.22, 10, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45005.2669307523, 0.61, 3954.5, 'true', 1),
((select id from t_id), (select id from i_id), 45005.2709251042, 0.61, 3956.5, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45005.2717371296, 45005.2740734144, 2.44, 8.75, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45005.2717371296, 0.61, 3953, 'false', 1),
((select id from t_id), (select id from i_id), 45005.2731026852, 0.61, 3961.75, 'false', 1),
((select id from t_id), (select id from i_id), 45005.2740734028, 0.61, 3956.5, 'true', 1),
((select id from t_id), (select id from i_id), 45005.2740734144, 0.61, 3956.5, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45005.2817161458, 45005.2822903125, 1.22, 20, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45005.2817161458, 0.61, 3957.75, 'false', 1),
((select id from t_id), (select id from i_id), 45005.2822903125, 0.61, 3953.75, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45005.2903604167, 45005.291085463, 1.22, 10, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45005.2903604167, 0.61, 3965.5, 'false', 1),
((select id from t_id), (select id from i_id), 45005.291085463, 0.61, 3963.5, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45005.2991106597, 45005.2993805671, 1.22, 6.25, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45005.2991106597, 0.61, 3962.75, 'true', 1),
((select id from t_id), (select id from i_id), 45005.2993805671, 0.61, 3964, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45005.3028639236, 45005.3032309838, 1.22, 2.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45005.3028639236, 0.61, 3966.25, 'true', 1),
((select id from t_id), (select id from i_id), 45005.3032309838, 0.61, 3966.75, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45006.2887457176, 45006.2905062732, 1.22, -6.25, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45006.2887457176, 0.61, 4024.25, 'false', 1),
((select id from t_id), (select id from i_id), 45006.2905062732, 0.61, 4025.5, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45006.2950332407, 45006.2957475, 1.22, 10, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45006.2950332407, 0.61, 4023, 'false', 1),
((select id from t_id), (select id from i_id), 45006.2957475, 0.61, 4021, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45006.3158831366, 45006.3168119097, 1.22, -10, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45006.3158831366, 0.61, 4010, 'true', 1),
((select id from t_id), (select id from i_id), 45006.3168119097, 0.61, 4008, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45006.3279012384, 45006.3296961574, 1.22, 1.25, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45006.3279012384, 0.61, 4009.75, 'true', 1),
((select id from t_id), (select id from i_id), 45006.3296961574, 0.61, 4010, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45006.3515984838, 45006.3519400116, 1.22, 16.25, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45006.3515984838, 0.61, 4019.25, 'false', 1),
((select id from t_id), (select id from i_id), 45006.3519400116, 0.61, 4016, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45007.3079119792, 45007.3105557176, 1.22, -11.25, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45007.3079119792, 0.61, 4039.5, 'false', 1),
((select id from t_id), (select id from i_id), 45007.3105557176, 0.61, 4041.75, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45007.3152387268, 45007.3206087153, 1.22, 3.75, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45007.3152387268, 0.61, 4044.25, 'false', 1),
((select id from t_id), (select id from i_id), 45007.3206087153, 0.61, 4043.5, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45007.343338588, 45007.3439625116, 1.22, 5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45007.343338588, 0.61, 4035, 'true', 1),
((select id from t_id), (select id from i_id), 45007.3439625116, 0.61, 4036, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45007.4182908796, 45007.421231713, 1.22, -11.25, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45007.4182908796, 0.61, 4024.75, 'true', 1),
((select id from t_id), (select id from i_id), 45007.421231713, 0.61, 4022.5, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45007.4614579398, 45007.4619141204, 1.22, -23.75, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45007.4614579398, 0.61, 4050.5, 'false', 1),
((select id from t_id), (select id from i_id), 45007.4619141204, 0.61, 4055.25, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45007.4625137384, 45007.4625593519, 1.22, -10, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45007.4625137384, 0.61, 4058.5, 'false', 1),
((select id from t_id), (select id from i_id), 45007.4625593519, 0.61, 4060.5, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45007.4627706481, 45007.4632565856, 1.22, 27.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45007.4627706481, 0.61, 4064.75, 'false', 1),
((select id from t_id), (select id from i_id), 45007.4632565856, 0.61, 4059.25, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45007.4640017245, 45007.4641707986, 1.22, 6.25, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45007.4640017245, 0.61, 4054.75, 'true', 1),
((select id from t_id), (select id from i_id), 45007.4641707986, 0.61, 4056, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45007.4646881366, 45007.466419838, 2.44, -60, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45007.4646881366, 0.61, 4052.25, 'true', 1),
((select id from t_id), (select id from i_id), 45007.4663102778, 0.61, 4048.75, 'true', 1),
((select id from t_id), (select id from i_id), 45007.4664196412, 0.61, 4044.5, 'false', 1),
((select id from t_id), (select id from i_id), 45007.466419838, 0.61, 4044.5, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45007.4679842014, 45007.4684051157, 1.22, -2.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45007.4679842014, 0.61, 4038.75, 'false', 1),
((select id from t_id), (select id from i_id), 45007.4684051157, 0.61, 4039.25, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45008.2814057407, 45008.2820845139, 1.22, 2.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45008.2814057407, 0.61, 4006.75, 'true', 1),
((select id from t_id), (select id from i_id), 45008.2820845139, 0.61, 4007.25, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45008.2850027778, 45008.2853019907, 1.22, 10, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45008.2850027778, 0.61, 4005.75, 'false', 1),
((select id from t_id), (select id from i_id), 45008.2853019907, 0.61, 4003.75, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45008.3009036921, 45008.301802037, 1.22, 7.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45008.3009036921, 0.61, 4012.25, 'true', 1),
((select id from t_id), (select id from i_id), 45008.301802037, 0.61, 4013.75, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45008.3071957407, 45008.3072577894, 1.22, 3.75, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45008.3071957407, 0.61, 4010.25, 'true', 1),
((select id from t_id), (select id from i_id), 45008.3072577894, 0.61, 4011, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45008.316666412, 45008.3169736111, 1.22, -10, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45008.316666412, 0.61, 4012.25, 'true', 1),
((select id from t_id), (select id from i_id), 45008.3169736111, 0.61, 4010.25, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45008.3174514931, 45008.3183904167, 1.22, 5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45008.3174514931, 0.61, 4011.5, 'true', 1),
((select id from t_id), (select id from i_id), 45008.3183904167, 0.61, 4012.5, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45008.3222717593, 45008.3224348032, 1.22, 5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45008.3222717593, 0.61, 4017.75, 'false', 1),
((select id from t_id), (select id from i_id), 45008.3224348032, 0.61, 4016.75, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45009.2486299884, 45009.2505709375, 1.22, 10, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45009.2486299884, 0.61, 3955.5, 'false', 1),
((select id from t_id), (select id from i_id), 45009.2505709375, 0.61, 3953.5, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45009.2739253704, 45009.2741835069, 1.22, 5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45009.2739253704, 0.61, 3955.75, 'true', 1),
((select id from t_id), (select id from i_id), 45009.2741835069, 0.61, 3956.75, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45009.3224161574, 45009.3232572454, 1.22, 10, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45009.3224161574, 0.61, 3956, 'true', 1),
((select id from t_id), (select id from i_id), 45009.3232572454, 0.61, 3958, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45012.2709516435, 45012.2713721181, 1.22, 10, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45012.2709516435, 0.61, 4026.75, 'false', 1),
((select id from t_id), (select id from i_id), 45012.2713721181, 0.61, 4024.75, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45012.3111013773, 45012.3154714236, 2.44, -52.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45012.3111013773, 0.61, 4019.25, 'true', 1),
((select id from t_id), (select id from i_id), 45012.313148044, 0.61, 4012.25, 'true', 1),
((select id from t_id), (select id from i_id), 45012.315471412, 0.61, 4010.5, 'false', 1),
((select id from t_id), (select id from i_id), 45012.3154714236, 0.61, 4010.5, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45012.318933831, 45012.3242973727, 2.44, 22.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45012.318933831, 0.61, 4011.75, 'true', 1),
((select id from t_id), (select id from i_id), 45012.3230728241, 0.61, 4008.25, 'true', 1),
((select id from t_id), (select id from i_id), 45012.324291088, 0.61, 4012.25, 'false', 1),
((select id from t_id), (select id from i_id), 45012.3242973727, 0.61, 4012.25, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45012.3248559375, 45012.325238669, 1.22, 15, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45012.3248559375, 0.61, 4013.25, 'false', 1),
((select id from t_id), (select id from i_id), 45012.325238669, 0.61, 4010.25, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45012.3337742824, 45012.3354167593, 2.44, 10, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45012.3337742824, 0.61, 4009.25, 'true', 1),
((select id from t_id), (select id from i_id), 45012.3351081597, 0.61, 4007.25, 'true', 1),
((select id from t_id), (select id from i_id), 45012.3354159722, 0.61, 4009.25, 'false', 1),
((select id from t_id), (select id from i_id), 45012.3354167593, 0.61, 4009.25, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45012.467196088, 45012.4762023958, 3.66, -72.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45012.467196088, 0.61, 4012.5, 'false', 1),
((select id from t_id), (select id from i_id), 45012.4704912847, 0.61, 4015.25, 'false', 1),
((select id from t_id), (select id from i_id), 45012.4737848148, 0.61, 4017.75, 'false', 1),
((select id from t_id), (select id from i_id), 45012.4762023958, 1.83, 4020, 'true', 3);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45013.2467640162, 45013.2484040857, 1.22, 5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45013.2467640162, 0.61, 3998.25, 'true', 1),
((select id from t_id), (select id from i_id), 45013.2484040857, 0.61, 3999.25, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45013.2716695023, 45013.2718007755, 1.22, 2.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45013.2716695023, 0.61, 3999, 'false', 1),
((select id from t_id), (select id from i_id), 45013.2718007755, 0.61, 3998.5, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45013.2724773495, 45013.2742562153, 4.88, 17.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45013.2724773495, 1.22, 3997.75, 'true', 2),
((select id from t_id), (select id from i_id), 45013.2735604167, 0.61, 3994.5, 'true', 1),
((select id from t_id), (select id from i_id), 45013.2737028125, 0.61, 3994.5, 'true', 1),
((select id from t_id), (select id from i_id), 45013.2739960532, 0.61, 3996.75, 'false', 1),
((select id from t_id), (select id from i_id), 45013.2739960648, 1.22, 3996.75, 'false', 2),
((select id from t_id), (select id from i_id), 45013.2742562153, 0.61, 3998.75, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45013.2746847685, 45013.2764537616, 2.44, 15, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45013.2746847685, 1.22, 3998.75, 'false', 2),
((select id from t_id), (select id from i_id), 45013.2756964468, 0.61, 3996.75, 'true', 1),
((select id from t_id), (select id from i_id), 45013.2764537616, 0.61, 3997.75, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45013.2777520255, 45013.2780881944, 1.22, 6.25, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45013.2777520255, 0.61, 3999.75, 'true', 1),
((select id from t_id), (select id from i_id), 45013.2780881944, 0.61, 4001, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45013.2806020833, 45013.2810858333, 1.22, 3.75, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45013.2806020833, 0.61, 4000.75, 'false', 1),
((select id from t_id), (select id from i_id), 45013.2810858333, 0.61, 4000, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45013.3303371643, 45013.3305640278, 1.22, 1.25, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45013.3303371643, 0.61, 3992.5, 'true', 1),
((select id from t_id), (select id from i_id), 45013.3305640278, 0.61, 3992.75, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45013.4257314931, 45013.4262479977, 1.22, 1.25, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45013.4257314931, 0.61, 3993.5, 'false', 1),
((select id from t_id), (select id from i_id), 45013.4262479977, 0.61, 3993.25, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45013.449683206, 45013.4524212269, 1.22, 1.25, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45013.449683206, 0.61, 3985, 'false', 1),
((select id from t_id), (select id from i_id), 45013.4524212269, 0.61, 3984.75, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45013.5206134144, 45013.5208593634, 1.22, 2.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45013.5206134144, 0.61, 3990.75, 'false', 1),
((select id from t_id), (select id from i_id), 45013.5208593634, 0.61, 3990.25, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45013.5242821644, 45013.5267795023, 2.44, 2.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45013.5242821644, 0.61, 3993.5, 'false', 1),
((select id from t_id), (select id from i_id), 45013.5256949653, 0.61, 3996, 'false', 1),
((select id from t_id), (select id from i_id), 45013.5267792593, 0.61, 3994.5, 'true', 1),
((select id from t_id), (select id from i_id), 45013.5267795023, 0.61, 3994.5, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45015.2919196759, 45015.2923428472, 2.44, 10, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45015.2919196759, 1.22, 4086.25, 'false', 2),
((select id from t_id), (select id from i_id), 45015.2922961574, 0.61, 4085.25, 'true', 1),
((select id from t_id), (select id from i_id), 45015.2923428472, 0.61, 4085.25, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45015.2954725116, 45015.3005606481, 2.44, -65, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45015.2954725116, 1.22, 4079.25, 'true', 2),
((select id from t_id), (select id from i_id), 45015.3005606481, 1.22, 4072.75, 'false', 2);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45015.3007590162, 45015.3007590625, 1.22, -1.25, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45015.3007590162, 0.61, 4073.75, 'false', 1),
((select id from t_id), (select id from i_id), 45015.3007590625, 0.61, 4074, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45015.3027421412, 45015.3027487731, 2.44, 0, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45015.3027421412, 0.61, 4074.75, 'false', 1),
((select id from t_id), (select id from i_id), 45015.3027421528, 0.61, 4074.75, 'false', 1),
((select id from t_id), (select id from i_id), 45015.3027487731, 1.22, 4074.75, 'true', 2);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45016.3032265972, 45016.3033504051, 2.44, 2.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45016.3032265972, 1.22, 4099, 'false', 2),
((select id from t_id), (select id from i_id), 45016.3033503935, 0.61, 4098.75, 'true', 1),
((select id from t_id), (select id from i_id), 45016.3033504051, 0.61, 4098.75, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45016.3112995255, 45016.3119840162, 1.22, 5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45016.3112995255, 0.61, 4102.75, 'false', 1),
((select id from t_id), (select id from i_id), 45016.3119840162, 0.61, 4101.75, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45019.2716353588, 45019.272008125, 2.44, 20, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45019.2716353588, 1.22, 4133.75, 'true', 2),
((select id from t_id), (select id from i_id), 45019.2718732292, 0.61, 4135.75, 'false', 1),
((select id from t_id), (select id from i_id), 45019.272008125, 0.61, 4135.75, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45019.272530706, 45019.2752385417, 4.88, -85, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45019.272530706, 1.22, 4134.75, 'false', 2),
((select id from t_id), (select id from i_id), 45019.2745575116, 1.22, 4138.25, 'false', 2),
((select id from t_id), (select id from i_id), 45019.2752385185, 0.61, 4140.75, 'true', 1),
((select id from t_id), (select id from i_id), 45019.2752385417, 1.83, 4140.75, 'true', 3);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45019.2756075, 45019.2775749769, 2.44, 5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45019.2756075, 1.22, 4141.5, 'true', 2),
((select id from t_id), (select id from i_id), 45019.2775749769, 1.22, 4142, 'false', 2);


insert into instruments (code, price_per_point)
values ('MNQ', 2)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MNQ'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45008.3437653241, 45008.3444709028, 3.6599999999999997, 5.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45008.3437653241, 0.61, 13012.75, 'true', 1),
((select id from t_id), (select id from i_id), 45008.3442898032, 0.61, 13007.5, 'true', 1),
((select id from t_id), (select id from i_id), 45008.3442911806, 0.61, 13007, 'true', 1),
((select id from t_id), (select id from i_id), 45008.3444708912, 1.22, 13010, 'false', 2),
((select id from t_id), (select id from i_id), 45008.3444709028, 0.61, 13010, 'false', 1);


insert into instruments (code, price_per_point)
values ('MNQ', 2)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MNQ'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45008.3447003241, 45008.3447133565, 1.22, -4.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45008.3447003241, 0.61, 13005.5, 'true', 1),
((select id from t_id), (select id from i_id), 45008.3447133565, 0.61, 13003.25, 'false', 1);


insert into instruments (code, price_per_point)
values ('MNQ', 2)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-06!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'MNQ'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45008.3447662963, 45008.349497662, 3.6599999999999997, 10, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45008.3447662963, 0.61, 13002.5, 'true', 1),
((select id from t_id), (select id from i_id), 45008.3450690856, 0.61, 12996.75, 'true', 1),
((select id from t_id), (select id from i_id), 45008.345683125, 0.61, 12996.5, 'true', 1),
((select id from t_id), (select id from i_id), 45008.3494976389, 0.61, 13000.25, 'false', 1),
((select id from t_id), (select id from i_id), 45008.3494976505, 0.61, 13000.25, 'false', 1),
((select id from t_id), (select id from i_id), 45008.349497662, 0.61, 13000.25, 'false', 1);


insert into accounts (user_id, name, sim)
values ('6982c6df-3d03-4583-8fa9-07386cf25f80', 'PA-APEX-30411-02!Apex!Apex', false)
on conflict ("name") do nothing;

insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-02!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45148.2976997801, 45148.2977683796, 0, 50, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45148.2976997801, 0, 4539.75, 'true', 1),
((select id from t_id), (select id from i_id), 45148.2977683796, 0, 4540.75, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-02!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45148.3466316782, 45148.3473721991, 0, 50, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45148.3466316782, 0, 4511.25, 'false', 1),
((select id from t_id), (select id from i_id), 45148.3473721991, 0, 4510.25, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-02!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45148.353168206, 45148.3540065972, 0, -225, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45148.353168206, 0, 4512.75, 'false', 1),
((select id from t_id), (select id from i_id), 45148.3535257523, 0, 4513.75, 'false', 1),
((select id from t_id), (select id from i_id), 45148.3540065857, 0, 4515.5, 'true', 1),
((select id from t_id), (select id from i_id), 45148.3540065972, 0, 4515.5, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-02!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45148.3541839468, 45148.355354838, 0, 12.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45148.3541839468, 0, 4515, 'false', 1),
((select id from t_id), (select id from i_id), 45148.355354838, 0, 4514.75, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-02!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45148.355665625, 45148.3576083796, 0, 287.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45148.355665625, 0, 4513.75, 'true', 1),
((select id from t_id), (select id from i_id), 45148.3576083796, 0, 4519.5, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-02!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45149.270930463, 45149.2716587847, 0, 100, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45149.270930463, 0, 4465.5, 'false', 1),
((select id from t_id), (select id from i_id), 45149.2716587847, 0, 4463.5, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-02!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45149.2824860648, 45149.2858437616, 12.54, 150, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45149.2824860648, 2.09, 4462.75, 'false', 1),
((select id from t_id), (select id from i_id), 45149.2828213657, 2.09, 4464.5, 'false', 1),
((select id from t_id), (select id from i_id), 45149.2841938542, 2.09, 4466.25, 'false', 1),
((select id from t_id), (select id from i_id), 45149.2858436806, 2.09, 4463.5, 'true', 1),
((select id from t_id), (select id from i_id), 45149.2858437384, 2.09, 4463.5, 'true', 1),
((select id from t_id), (select id from i_id), 45149.2858437616, 2.09, 4463.5, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-02!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45152.2746565278, 45152.2750100231, 8.36, -175, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45152.2746565278, 2.09, 4474.75, 'true', 1),
((select id from t_id), (select id from i_id), 45152.2749828009, 2.09, 4473.25, 'true', 1),
((select id from t_id), (select id from i_id), 45152.2750100116, 2.09, 4472.25, 'false', 1),
((select id from t_id), (select id from i_id), 45152.2750100231, 2.09, 4472.25, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-02!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45152.2751891782, 45152.2757565856, 4.18, -100, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45152.2751891782, 2.09, 4472.25, 'true', 1),
((select id from t_id), (select id from i_id), 45152.2757565856, 2.09, 4470.25, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-02!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45152.2760235648, 45152.2800197569, 4.18, 262.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45152.2760235648, 2.09, 4471.5, 'true', 1),
((select id from t_id), (select id from i_id), 45152.2800197569, 2.09, 4476.75, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-02!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45152.2848836806, 45152.285210787, 4.18, -100, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45152.2848836806, 2.09, 4470.25, 'false', 1),
((select id from t_id), (select id from i_id), 45152.285210787, 2.09, 4472.25, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-02!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45152.2876219444, 45152.2885160648, 4.18, -100, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45152.2876219444, 2.09, 4475.75, 'true', 1),
((select id from t_id), (select id from i_id), 45152.2885160648, 2.09, 4473.75, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-02!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45152.2886700926, 45152.2903959144, 8.36, 150, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45152.2886700926, 2.09, 4474, 'true', 1),
((select id from t_id), (select id from i_id), 45152.2899770949, 2.09, 4475, 'true', 1),
((select id from t_id), (select id from i_id), 45152.2903959028, 2.09, 4476, 'false', 1),
((select id from t_id), (select id from i_id), 45152.2903959144, 2.09, 4476, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-02!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45152.3145480093, 45152.315129375, 4.18, 50, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45152.3145480093, 2.09, 4486, 'true', 1),
((select id from t_id), (select id from i_id), 45152.315129375, 2.09, 4487, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-02!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45152.3366284838, 45152.3375328819, 4.18, 62.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45152.3366284838, 2.09, 4495.5, 'false', 1),
((select id from t_id), (select id from i_id), 45152.3375328819, 2.09, 4494.25, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-02!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45152.536720162, 45152.5375173264, 4.18, 50, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45152.536720162, 2.09, 4497.5, 'true', 1),
((select id from t_id), (select id from i_id), 45152.5375173264, 2.09, 4498.5, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-02!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45153.2460460995, 45153.24764, 4.18, 50, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45153.2460460995, 2.09, 4475.75, 'true', 1),
((select id from t_id), (select id from i_id), 45153.24764, 2.09, 4476.75, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-02!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45153.2765245949, 45153.2766662153, 4.18, 62.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45153.2765245949, 2.09, 4486.5, 'true', 1),
((select id from t_id), (select id from i_id), 45153.2766662153, 2.09, 4487.75, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-02!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45154.288733125, 45154.2892671875, 4.18, 12.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45154.288733125, 2.09, 4458.5, 'false', 1),
((select id from t_id), (select id from i_id), 45154.2892671875, 2.09, 4458.25, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-02!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45154.2908241088, 45154.2910753009, 4.18, 12.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45154.2908241088, 2.09, 4460, 'false', 1),
((select id from t_id), (select id from i_id), 45154.2910753009, 2.09, 4459.75, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-02!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45154.313064537, 45154.3131725694, 4.18, 25, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45154.313064537, 2.09, 4458, 'true', 1),
((select id from t_id), (select id from i_id), 45154.3131725694, 2.09, 4458.5, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-02!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45155.2599210417, 45155.2710275232, 4.18, 50, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45155.2599210417, 2.09, 4433, 'true', 1),
((select id from t_id), (select id from i_id), 45155.2710275232, 2.09, 4434, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-02!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45155.2826205671, 45155.2830533333, 4.18, 12.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45155.2826205671, 2.09, 4426, 'true', 1),
((select id from t_id), (select id from i_id), 45155.2830533333, 2.09, 4426.25, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-02!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45155.2886056019, 45155.2888526389, 4.18, 12.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45155.2886056019, 2.09, 4421, 'false', 1),
((select id from t_id), (select id from i_id), 45155.2888526389, 2.09, 4420.75, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-02!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45155.2913625116, 45155.2922297569, 4.18, -100, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45155.2913625116, 2.09, 4425, 'false', 1),
((select id from t_id), (select id from i_id), 45155.2922297569, 2.09, 4427, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-02!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45155.2928885995, 45155.2945129167, 8.36, 100, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45155.2928885995, 2.09, 4426.5, 'true', 1),
((select id from t_id), (select id from i_id), 45155.2938846412, 2.09, 4424.5, 'true', 1),
((select id from t_id), (select id from i_id), 45155.2945127431, 2.09, 4426.5, 'false', 1),
((select id from t_id), (select id from i_id), 45155.2945129167, 2.09, 4426.5, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-02!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45155.2991427894, 45155.2993441551, 4.18, -100, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45155.2991427894, 2.09, 4427, 'true', 1),
((select id from t_id), (select id from i_id), 45155.2993441551, 2.09, 4425, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-02!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45155.2995673727, 45155.3004131019, 4.18, -100, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45155.2995673727, 2.09, 4426.25, 'true', 1),
((select id from t_id), (select id from i_id), 45155.3004131019, 2.09, 4424.25, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-02!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45155.3006179282, 45155.3012307639, 8.36, -162.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45155.3006179282, 2.09, 4423.75, 'true', 1),
((select id from t_id), (select id from i_id), 45155.3011479514, 2.09, 4422, 'true', 1),
((select id from t_id), (select id from i_id), 45155.3012307523, 2.09, 4421.25, 'false', 1),
((select id from t_id), (select id from i_id), 45155.3012307639, 2.09, 4421.25, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-02!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45155.3014695486, 45155.3021576389, 8.36, -212.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45155.3014695486, 2.09, 4421, 'false', 1),
((select id from t_id), (select id from i_id), 45155.3021451505, 2.09, 4423.75, 'false', 1),
((select id from t_id), (select id from i_id), 45155.3021575347, 2.09, 4424.5, 'true', 1),
((select id from t_id), (select id from i_id), 45155.3021576389, 2.09, 4424.5, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-02!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45155.3022098727, 45155.30275625, 8.36, 275, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45155.3022098727, 2.09, 4424, 'true', 1),
((select id from t_id), (select id from i_id), 45155.3023634491, 2.09, 4424, 'true', 1),
((select id from t_id), (select id from i_id), 45155.3027562384, 2.09, 4426.75, 'false', 1),
((select id from t_id), (select id from i_id), 45155.30275625, 2.09, 4426.75, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-02!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45159.2737569329, 45159.2739619907, 4.18, 87.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45159.2737569329, 2.09, 4396.5, 'true', 1),
((select id from t_id), (select id from i_id), 45159.2739619907, 2.09, 4398.25, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-02!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45159.2840612037, 45159.2845675579, 4.18, 50, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45159.2840612037, 2.09, 4397, 'true', 1),
((select id from t_id), (select id from i_id), 45159.2845675579, 2.09, 4398, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-02!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45159.3058895718, 45159.3061832755, 4.18, 25, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45159.3058895718, 2.09, 4395.75, 'true', 1),
((select id from t_id), (select id from i_id), 45159.3061832755, 2.09, 4396.25, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-02!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45160.2756916204, 45160.276319456, 4.18, 62.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45160.2756916204, 2.09, 4426.25, 'false', 1),
((select id from t_id), (select id from i_id), 45160.276319456, 2.09, 4425, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-02!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45160.2816376968, 45160.2820398032, 4.18, 50, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45160.2816376968, 2.09, 4423, 'false', 1),
((select id from t_id), (select id from i_id), 45160.2820398032, 2.09, 4422, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-02!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45160.3094652431, 45160.3100010069, 4.18, -100, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45160.3094652431, 2.09, 4416.5, 'true', 1),
((select id from t_id), (select id from i_id), 45160.3100010069, 2.09, 4414.5, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-02!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45160.3254987963, 45160.3280096181, 4.18, -62.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45160.3254987963, 2.09, 4411.25, 'false', 1),
((select id from t_id), (select id from i_id), 45160.3280096181, 2.09, 4412.5, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-02!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45160.3376434722, 45160.3380251273, 4.18, 62.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45160.3376434722, 2.09, 4411.25, 'true', 1),
((select id from t_id), (select id from i_id), 45160.3380251273, 2.09, 4412.5, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-02!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45161.2423339815, 45161.2465384722, 4.18, 137.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45161.2423339815, 2.09, 4405, 'false', 1),
((select id from t_id), (select id from i_id), 45161.2465384722, 2.09, 4402.25, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'PA-APEX-30411-02!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45162.2400791435, 45162.2407010069, 4.18, 112.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45162.2400791435, 2.09, 4465, 'true', 1),
((select id from t_id), (select id from i_id), 45162.2407010069, 2.09, 4467.25, 'false', 1);


insert into accounts (user_id, name, sim)
values ('6982c6df-3d03-4583-8fa9-07386cf25f80', 'APEX-30411-09!Apex!Apex', false)
on conflict ("name") do nothing;

insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-09!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45140.2712047917, 45140.2712730324, 8.36, -200, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45140.2712047917, 4.18, 4567, 'false', 2),
((select id from t_id), (select id from i_id), 45140.2712730324, 4.18, 4569, 'true', 2);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-09!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45140.2713239468, 45140.271885625, 8.36, 362.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45140.2713239468, 4.18, 4568.75, 'false', 2),
((select id from t_id), (select id from i_id), 45140.2718007639, 2.09, 4566, 'true', 1),
((select id from t_id), (select id from i_id), 45140.271885625, 2.09, 4564.25, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-09!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45140.2828691667, 45140.2832716088, 4.18, 12.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45140.2828691667, 2.09, 4564.25, 'true', 1),
((select id from t_id), (select id from i_id), 45140.2832716088, 2.09, 4564.5, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-09!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45140.2875008449, 45140.2876814583, 4.18, -112.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45140.2875008449, 2.09, 4565.25, 'true', 1),
((select id from t_id), (select id from i_id), 45140.2876814583, 2.09, 4563, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-09!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45140.2881622107, 45140.2921892824, 16.72, 87.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45140.2881622107, 4.18, 4562.5, 'false', 2),
((select id from t_id), (select id from i_id), 45140.2893654282, 4.18, 4564.5, 'false', 2),
((select id from t_id), (select id from i_id), 45140.2920879398, 6.27, 4563, 'true', 3),
((select id from t_id), (select id from i_id), 45140.2921892824, 2.09, 4562.75, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-09!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45140.3112274306, 45140.3132079051, 4.18, 50, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45140.3112274306, 2.09, 4556, 'true', 1),
((select id from t_id), (select id from i_id), 45140.3132079051, 2.09, 4557, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-09!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45141.2720727662, 45141.2722978241, 4.18, 25, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45141.2720727662, 2.09, 4512.75, 'false', 1),
((select id from t_id), (select id from i_id), 45141.2722978241, 2.09, 4512.25, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-09!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45141.2741369792, 45141.2742852083, 4.18, 12.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45141.2741369792, 2.09, 4512, 'false', 1),
((select id from t_id), (select id from i_id), 45141.2742852083, 2.09, 4511.75, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-09!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45141.2749689236, 45141.275069375, 4.18, 25, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45141.2749689236, 2.09, 4515.75, 'false', 1),
((select id from t_id), (select id from i_id), 45141.275069375, 2.09, 4515.25, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-09!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45141.2779078588, 45141.2783308681, 4.18, 87.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45141.2779078588, 2.09, 4513.25, 'false', 1),
((select id from t_id), (select id from i_id), 45141.2783308681, 2.09, 4511.5, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-09!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45141.2957638657, 45141.2958951852, 4.18, 50, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45141.2957638657, 2.09, 4520.75, 'true', 1),
((select id from t_id), (select id from i_id), 45141.2958951852, 2.09, 4521.75, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-09!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45145.2765744329, 45145.2774778935, 4.18, -100, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45145.2765744329, 2.09, 4526.25, 'true', 1),
((select id from t_id), (select id from i_id), 45145.2774778935, 2.09, 4524.25, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-09!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45145.2776678472, 45145.2787054514, 8.36, -275, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45145.2776678472, 4.18, 4524, 'true', 2),
((select id from t_id), (select id from i_id), 45145.2787053472, 2.09, 4521.25, 'false', 1),
((select id from t_id), (select id from i_id), 45145.2787054514, 2.09, 4521.25, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-09!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45145.2789975116, 45145.2869347917, 16.72, 550, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45145.2789975116, 4.18, 4521.5, 'true', 2),
((select id from t_id), (select id from i_id), 45145.2807880093, 4.18, 4516, 'true', 2),
((select id from t_id), (select id from i_id), 45145.2868759375, 2.09, 4521.25, 'false', 1),
((select id from t_id), (select id from i_id), 45145.2868759491, 2.09, 4521.25, 'false', 1),
((select id from t_id), (select id from i_id), 45145.2868759606, 2.09, 4521.25, 'false', 1),
((select id from t_id), (select id from i_id), 45145.2869347917, 2.09, 4522.25, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-09!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45146.2974766435, 45146.2989688542, 4.18, -100, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45146.2974766435, 2.09, 4496, 'true', 1),
((select id from t_id), (select id from i_id), 45146.2989688542, 2.09, 4494, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-09!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45146.3006219213, 45146.300717419, 4.18, -100, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45146.3006219213, 2.09, 4491.5, 'false', 1),
((select id from t_id), (select id from i_id), 45146.300717419, 2.09, 4493.5, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-09!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45146.3007891088, 45146.301466794, 8.36, 237.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45146.3007891088, 4.18, 4492.75, 'false', 2),
((select id from t_id), (select id from i_id), 45146.301306331, 2.09, 4490.75, 'true', 1),
((select id from t_id), (select id from i_id), 45146.301466794, 2.09, 4490, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-09!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45146.3048488889, 45146.3063298495, 4.18, 50, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45146.3048488889, 2.09, 4487.25, 'false', 1),
((select id from t_id), (select id from i_id), 45146.3063298495, 2.09, 4486.25, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'APEX-30411-09!Apex!Apex'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45146.4239847917, 45146.4254145602, 4.18, 50, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45146.4239847917, 2.09, 4496.5, 'true', 1),
((select id from t_id), (select id from i_id), 45146.4254145602, 2.09, 4497.5, 'false', 1);


insert into accounts (user_id, name, sim)
values ('6982c6df-3d03-4583-8fa9-07386cf25f80', 'Sim101', true)
on conflict ("name") do nothing;

insert into instruments (code, price_per_point)
values ('MNQ', 2)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'Sim101'
), i_id as (
    select id from instruments
    where code = 'MNQ'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45007.2978951042, 45007.2982369097, 2.44, 15, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45007.2978951042, 1.22, 12884.25, 'false', 2),
((select id from t_id), (select id from i_id), 45007.298103912, 0.61, 12881.75, 'true', 1),
((select id from t_id), (select id from i_id), 45007.2982369097, 0.61, 12879.25, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'Sim101'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45001.2782827431, 45001.2784709838, 1.12, -10, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45001.2782827431, 0.56, 3910.5, 'false', 1),
((select id from t_id), (select id from i_id), 45001.2784709838, 0.56, 3912.5, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'Sim101'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45001.4431818981, 45001.4470816898, 1.12, 3.75, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45001.4431818981, 0.56, 3982, 'true', 1),
((select id from t_id), (select id from i_id), 45001.4470816898, 0.56, 3982.75, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'Sim101'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45001.4524104282, 45001.4825832639, 1.12, 52.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45001.4524104282, 0.56, 3984.25, 'false', 1),
((select id from t_id), (select id from i_id), 45001.4825832639, 0.56, 3973.75, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'Sim101'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45005.2846304514, 45005.285567037, 1.22, -15, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45005.2846304514, 0.61, 3960, 'false', 1),
((select id from t_id), (select id from i_id), 45005.285567037, 0.61, 3963, 'true', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'Sim101'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45007.2934836921, 45007.2954681597, 2.44, -21.25, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45007.2934836921, 0.61, 4032.5, 'false', 1),
((select id from t_id), (select id from i_id), 45007.2937038542, 0.61, 4034.25, 'false', 1),
((select id from t_id), (select id from i_id), 45007.2954681597, 1.22, 4035.5, 'true', 2);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'Sim101'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45007.2954686806, 45007.2957822917, 1.22, -10, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45007.2954686806, 0.61, 4035.5, 'true', 1),
((select id from t_id), (select id from i_id), 45007.2957822917, 0.61, 4033.5, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'Sim101'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45124.267821331, 45124.2678570486, 4.88, -5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45124.267821331, 0.61, 4535.75, 'true', 1),
((select id from t_id), (select id from i_id), 45124.2678221759, 1.83, 4535.75, 'true', 3),
((select id from t_id), (select id from i_id), 45124.2678570486, 2.44, 4535.5, 'false', 4);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'Sim101'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45124.2816900694, 45124.2958224653, 4.880000000000001, 82.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45124.2816900694, 0.61, 4538.5, 'true', 1),
((select id from t_id), (select id from i_id), 45124.2816905093, 1.83, 4538.5, 'true', 3),
((select id from t_id), (select id from i_id), 45124.2913762269, 1.22, 4542.5, 'false', 2),
((select id from t_id), (select id from i_id), 45124.2913770486, 0.61, 4542.5, 'false', 1),
((select id from t_id), (select id from i_id), 45124.2958224653, 0.61, 4543, 'false', 1);


insert into instruments (code, price_per_point)
values ('MES', 5)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'Sim101'
), i_id as (
    select id from instruments
    where code = 'MES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45133.2729388657, 45133.2739526389, 4.88, 56.25, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45133.2729388657, 2.44, 4588.75, 'false', 4),
((select id from t_id), (select id from i_id), 45133.2732367014, 0.61, 4585.75, 'true', 1),
((select id from t_id), (select id from i_id), 45133.2732408102, 1.22, 4585.75, 'true', 2),
((select id from t_id), (select id from i_id), 45133.2739526389, 0.61, 4586.5, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'Sim101'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 44978.4797957755, 44978.4802206019, 0, -100, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 44978.4797957755, 0, 4005.75, 'false', 1),
((select id from t_id), (select id from i_id), 44978.4802206019, 0, 4007.75, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'Sim101'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 44978.4809613773, 44978.4825714468, 0, -50, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 44978.4809613773, 0, 4010.25, 'false', 1),
((select id from t_id), (select id from i_id), 44978.4825714468, 0, 4011.25, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'Sim101'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 44978.4826773843, 44978.4837069907, 0, -112.5, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 44978.4826773843, 0, 4011.5, 'true', 1),
((select id from t_id), (select id from i_id), 44978.4837069907, 0, 4009.25, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'Sim101'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 44984.5333789815, 44984.5410953588, 0, -112.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 44984.5333789815, 0, 3986.25, 'false', 1),
((select id from t_id), (select id from i_id), 44984.5410953588, 0, 3988.5, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'Sim101'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45007.2949638773, 45007.2950074074, 8.36, -50, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45007.2949638773, 4.18, 4034, 'true', 2),
((select id from t_id), (select id from i_id), 45007.2950074074, 4.18, 4033.5, 'false', 2);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'Sim101'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45007.2950877662, 45007.3011581597, 16.72, -325, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45007.2950877662, 2.09, 4033.75, 'true', 1),
((select id from t_id), (select id from i_id), 45007.2961652662, 2.09, 4034.25, 'true', 1),
((select id from t_id), (select id from i_id), 45007.3004814005, 4.18, 4032.75, 'true', 2),
((select id from t_id), (select id from i_id), 45007.3011576736, 2.09, 4031.75, 'false', 1),
((select id from t_id), (select id from i_id), 45007.3011579282, 2.09, 4031.75, 'false', 1),
((select id from t_id), (select id from i_id), 45007.3011581597, 4.18, 4031.75, 'false', 2);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'Sim101'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45008.5022049074, 45008.5022339699, 4.18, 100, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45008.5022049074, 2.09, 3974.5, 'true', 1),
((select id from t_id), (select id from i_id), 45008.5022339699, 2.09, 3976.5, 'false', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'Sim101'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45008.5401547338, 45008.544259919, 4.18, 412.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45008.5401547338, 2.09, 3984.75, 'false', 1),
((select id from t_id), (select id from i_id), 45008.544259919, 2.09, 3976.5, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'Sim101'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45013.5350726389, 45013.5354415278, 8.36, -162.5, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45013.5350726389, 2.09, 3996.5, 'false', 1),
((select id from t_id), (select id from i_id), 45013.5352522917, 2.09, 3997.25, 'false', 1),
((select id from t_id), (select id from i_id), 45013.5354412731, 2.09, 3998.5, 'true', 1),
((select id from t_id), (select id from i_id), 45013.5354415278, 2.09, 3998.5, 'true', 1);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'Sim101'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45013.5355941667, 45013.5361370486, 12.54, 300, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45013.5355941667, 2.09, 3998.25, 'true', 1),
((select id from t_id), (select id from i_id), 45013.5355943981, 2.09, 3998.25, 'true', 1),
((select id from t_id), (select id from i_id), 45013.5355946528, 2.09, 3998.25, 'true', 1),
((select id from t_id), (select id from i_id), 45013.5361370486, 6.27, 4000.25, 'false', 3);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'Sim101'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45013.5372839236, 45013.5378003472, 12.54, 275, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45013.5372839236, 2.09, 4000.5, 'false', 1),
((select id from t_id), (select id from i_id), 45013.5373322569, 2.09, 4000.25, 'false', 1),
((select id from t_id), (select id from i_id), 45013.5373325231, 2.09, 4000.25, 'false', 1),
((select id from t_id), (select id from i_id), 45013.5378001389, 2.09, 3998.5, 'true', 1),
((select id from t_id), (select id from i_id), 45013.5378003472, 4.18, 3998.5, 'true', 2);


insert into instruments (code, price_per_point)
values ('ES', 50)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'Sim101'
), i_id as (
    select id from instruments
    where code = 'ES'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45013.5448855556, 45013.5456406366, 4.18, 50, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45013.5448855556, 2.09, 4006.75, 'false', 1),
((select id from t_id), (select id from i_id), 45013.5456406366, 2.09, 4005.75, 'true', 1);


insert into instruments (code, price_per_point)
values ('NQ', 20)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'Sim101'
), i_id as (
    select id from instruments
    where code = 'NQ'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45007.2941168171, 45007.2942145718, 4.18, -25, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45007.2941168171, 2.09, 12885.75, 'false', 1),
((select id from t_id), (select id from i_id), 45007.2942145718, 2.09, 12887, 'true', 1);


insert into instruments (code, price_per_point)
values ('NQ', 20)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'Sim101'
), i_id as (
    select id from instruments
    where code = 'NQ'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45007.2944427662, 45007.2957044676, 8.36, 130, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45007.2944427662, 4.18, 12884.75, 'false', 2),
((select id from t_id), (select id from i_id), 45007.2957044676, 4.18, 12881.5, 'true', 2);


insert into instruments (code, price_per_point)
values ('NQ', 20)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'Sim101'
), i_id as (
    select id from instruments
    where code = 'NQ'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45007.295704919, 45007.2957898611, 8.36, -200, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45007.295704919, 4.18, 12881.25, 'true', 2),
((select id from t_id), (select id from i_id), 45007.2957895949, 2.09, 12876.25, 'false', 1),
((select id from t_id), (select id from i_id), 45007.2957898611, 2.09, 12876.25, 'false', 1);


insert into instruments (code, price_per_point)
values ('NQ', 20)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'Sim101'
), i_id as (
    select id from instruments
    where code = 'NQ'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45007.2969769676, 45007.2971756019, 8.36, -200, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45007.2969769676, 4.18, 12879, 'false', 2),
((select id from t_id), (select id from i_id), 45007.2971753935, 2.09, 12884, 'true', 1),
((select id from t_id), (select id from i_id), 45007.2971756019, 2.09, 12884, 'true', 1);


insert into instruments (code, price_per_point)
values ('NQ', 20)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'Sim101'
), i_id as (
    select id from instruments
    where code = 'NQ'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45007.2972697569, 45007.2973325926, 8.36, 40, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45007.2972697569, 4.18, 12886.75, 'false', 2),
((select id from t_id), (select id from i_id), 45007.2973325926, 4.18, 12885.75, 'true', 2);


insert into instruments (code, price_per_point)
values ('NQ', 20)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'Sim101'
), i_id as (
    select id from instruments
    where code = 'NQ'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45007.2973964468, 45007.2982170949, 8.36, 145, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45007.2973964468, 2.09, 12885.25, 'false', 1),
((select id from t_id), (select id from i_id), 45007.2973970486, 2.09, 12885, 'false', 1),
((select id from t_id), (select id from i_id), 45007.2974235301, 2.09, 12882.75, 'true', 1),
((select id from t_id), (select id from i_id), 45007.2982170949, 2.09, 12880.25, 'true', 1);


insert into instruments (code, price_per_point)
values ('NQ', 20)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'Sim101'
), i_id as (
    select id from instruments
    where code = 'NQ'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45007.3013220255, 45007.3035486111, 8.36, 215, false)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45007.3013220255, 2.09, 12868.75, 'true', 1),
((select id from t_id), (select id from i_id), 45007.3013227083, 2.09, 12868.75, 'true', 1),
((select id from t_id), (select id from i_id), 45007.3025282523, 2.09, 12871.25, 'false', 1),
((select id from t_id), (select id from i_id), 45007.3035486111, 2.09, 12877, 'false', 1);


insert into instruments (code, price_per_point)
values ('NQ', 20)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'Sim101'
), i_id as (
    select id from instruments
    where code = 'NQ'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45007.3052112153, 45007.3059956944, 8.36, -50, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45007.3052112153, 4.18, 12884.75, 'false', 2),
((select id from t_id), (select id from i_id), 45007.3052624769, 2.09, 12882.25, 'true', 1),
((select id from t_id), (select id from i_id), 45007.3059956944, 2.09, 12889.75, 'true', 1);


insert into instruments (code, price_per_point)
values ('NQ', 20)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'Sim101'
), i_id as (
    select id from instruments
    where code = 'NQ'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45007.3060473843, 45007.3062452778, 8.36, -200, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45007.3060473843, 4.18, 12891.5, 'false', 2),
((select id from t_id), (select id from i_id), 45007.3062449884, 2.09, 12896.5, 'true', 1),
((select id from t_id), (select id from i_id), 45007.3062452778, 2.09, 12896.5, 'true', 1);


insert into instruments (code, price_per_point)
values ('NQ', 20)
on conflict ("code") do nothing;

with acc_id as (
    select id from accounts
    where name = 'Sim101'
), i_id as (
    select id from instruments
    where code = 'NQ'
), t_id as (
    insert into trades (account_id, instrument_id, entry_time, exit_time, commissions, pnl, is_short)
    values ((select id from acc_id), (select id from i_id), 45007.3068671759, 45007.3073449421, 8.36, -200, true)
    returning id
)
insert into executions (trade_id, instrument_id, fill_time, commissions, price, is_buy, quantity)
values ((select id from t_id), (select id from i_id), 45007.3068671759, 4.18, 12895, 'false', 2),
((select id from t_id), (select id from i_id), 45007.3073446759, 2.09, 12900, 'true', 1),
((select id from t_id), (select id from i_id), 45007.3073449421, 2.09, 12900, 'true', 1);


