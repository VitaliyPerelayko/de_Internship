CREATE TABLE public.customers (
	customer_id varchar(100) NOT NULL,
	"FN" int2 NULL,
	"Active" int2 NULL,
	club_member_status varchar(50) NULL,
	fashion_news_frequency varchar(20) NULL,
	age int2 NULL,
	postal_code varchar(100) NULL,
	CONSTRAINT customers_pk PRIMARY KEY (customer_id)
);
