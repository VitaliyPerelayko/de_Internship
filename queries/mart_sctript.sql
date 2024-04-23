@set target_month_num = (select num from number_target_month limit 1)
@set part_date = '2018-12-31'::date
--create view without loyality and age
create or replace view grouped_by_customer as
	select 
	distinct tmt.customer_id as customer_id,
	sum(tmt.price) over(partition by tmt.customer_id) as transaction_amount,
	first_value(tmt.article_id) 
		over(partition by tmt.customer_id order by tmt.price desc, tmt.t_dat asc)
	as most_exp_article_id,
	count(tmt.article_id) over(partition by tmt.customer_id) as number_of_articles,
	(-1 + dense_rank() over(partition by tmt.customer_id order by a.product_group_name desc) +
	dense_rank() over(partition by tmt.customer_id order by a.product_group_name asc) 
	)as number_of_product_groups,
	case 
		when tmt.firs_decade_sum >= tmt.second_decade_sum and tmt.firs_decade_sum >= tmt.third_decade_sum
		then 1
		when tmt.second_decade_sum >= tmt.firs_decade_sum and tmt.second_decade_sum >= tmt.third_decade_sum
		then 2
		else 3
	end
	as most_active_decade
	from target_month_transactions tmt 
	left join articles a on tmt.article_id = a.article_id
;

-- isert final results
create or replace view data_mart as
select
${part_date} as part_date,
gbc.customer_id as customer_id,
case 
	when c.age < 23 then 'S'
	when c.age > 59 then 'R'
	else 'A'
end as customer_group_by_age,
gbc.transaction_amount as transaction_amount,
gbc.most_exp_article_id as most_exp_article_id,
gbc.number_of_articles as number_of_articles,
gbc.number_of_product_groups as number_of_product_groups,
gbc.most_active_decade as most_active_decade,
case 
	when ${target_month_num} = 1 then 1
	when ${target_month_num} = 2 and pmlc.customer_id is not null then 1
	when pmlc.customer_id is not null and tpmlc.customer_id is not null then 1
	else 0
end as customer_loyalty
from grouped_by_customer gbc
left join customers c on c.customer_id  = gbc.customer_id 
left join prev_month_loyal_customers pmlc on gbc.customer_id = pmlc.customer_id
left join two_prev_month_loyal_customers tpmlc on gbc.customer_id = tpmlc.customer_id;


