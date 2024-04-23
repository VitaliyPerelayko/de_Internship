-- aticles
copy articles 
from '/var/lib/postgresql/data/articles.csv'
delimiter ','
csv header;

-- customers
copy customers 
from '/var/lib/postgresql/data/customers.csv'
delimiter ','
csv header;

-- transactions_train
copy transactions_train 
from '/var/lib/postgresql/data/transactions_train.csv'
delimiter ','
csv header;
