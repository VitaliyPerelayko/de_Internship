@set part_date = '2018-12-31'::date
@set part_date_start = date_trunc('month', ${part_date})::date
-----------------------
@set prev_month_start = (${part_date_start} - interval '1 month')::date
@set prev_month_end = (${part_date_start} - interval '1 day')::date
-----------------------
@set two_prev_month_start = (${part_date_start} - interval '2 month')::date
@set two_prev_month_end = (${prev_month_start} - interval '1 day')::date


create or replace view number_target_month as
	select 
	(
		date_part('year', ${part_date}) - 
		(select date_part('year', t_dat) from transactions_train order by t_dat limit 1)
	) * 12 + 
	(
		date_part('month', ${part_date}) - 
		(select date_part('month', t_dat) from transactions_train order by t_dat limit 1)
	) +
	1 as num;
;

create or replace view target_month_transactions as
	select *,
	coalesce(
		sum(price) filter(where t_dat < ${part_date_start} + interval '10 day') over by_customer_id,
	0) as firs_decade_sum,
	coalesce(
		sum(price) 
		filter(where t_dat >= ${part_date_start} + interval '10 day'
			and t_dat < ${part_date_start} + interval '20 days')
		over by_customer_id,
	0) as second_decade_sum,
	coalesce(
		sum(price) filter(where t_dat >= ${part_date_start} + interval '20 day') over by_customer_id,
	0) as third_decade_sum
	from transactions_train tt
	where t_dat <= ${part_date} and t_dat >= ${part_date_start}
	window by_customer_id as (partition by customer_id)
;

create or replace view prev_month_loyal_customers as
	select customer_id
	from transactions_train
	where t_dat <= ${prev_month_end} and t_dat >= ${prev_month_start}
	group by customer_id
;

create or replace view two_prev_month_loyal_customers as
	select customer_id
	from transactions_train
	where t_dat <= ${two_prev_month_end} and t_dat >= ${two_prev_month_start}
	group by customer_id
;
