CREATE TABLE public.transactions_train (
	t_dat date NULL,
	customer_id varchar(100) NULL,
	article_id int8 NULL,
	price numeric(19, 18) NULL,
	sales_channel_id int2 NULL
);


ALTER TABLE public.transactions_train ADD CONSTRAINT transactions_train_articles_fk FOREIGN KEY (article_id) REFERENCES public.articles(article_id);
ALTER TABLE public.transactions_train ADD CONSTRAINT transactions_train_customers_fk FOREIGN KEY (customer_id) REFERENCES public.customers(customer_id);
