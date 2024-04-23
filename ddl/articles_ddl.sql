CREATE TABLE public.articles (
	article_id int8 NOT NULL,
	product_code int4 NULL,
	prod_name varchar(255) NULL,
	product_type_no int2 NULL,
	product_type_name varchar(100) NULL,
	product_group_name varchar(100) NULL,
	graphical_appearance_no int4 NULL,
	graphical_appearance_name varchar(100) NULL,
	colour_group_code int2 NULL,
	colour_group_name varchar(50) NULL,
	perceived_colour_value_id int2 NULL,
	perceived_colour_value_name varchar(50) NULL,
	perceived_colour_master_id int2 NULL,
	perceived_colour_master_name varchar(50) NULL,
	department_no int2 NULL,
	department_name varchar(50) NULL,
	index_code varchar(5) NULL,
	index_name varchar(50) NULL,
	index_group_no int2 NULL,
	index_group_name varchar(50) NULL,
	section_no int2 NULL,
	section_name varchar(50) NULL,
	garment_group_no int2 NULL,
	garment_group_name varchar(50) NULL,
	detail_desc text NULL,
	CONSTRAINT id PRIMARY KEY (article_id)
);
