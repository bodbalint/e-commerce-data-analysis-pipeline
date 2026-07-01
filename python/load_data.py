import pandas as pd
from sqlalchemy import create_engine

engine = create_engine('postgresql://postgres:DoubleInstaswap0@localhost:5432/ecommerce_pipeline')

customers = pd.read_csv("data/olist_customers_dataset.csv")
geolocation = pd.read_csv("data/olist_geolocation_dataset.csv")
order_items = pd.read_csv("data/olist_order_items_dataset.csv")
order_payments = pd.read_csv("data/olist_order_payments_dataset.csv")
order_reviews = pd.read_csv("data/olist_order_reviews_dataset.csv")
orders = pd.read_csv("data/olist_orders_dataset.csv")
products = pd.read_csv("data/olist_products_dataset.csv")
sellers = pd.read_csv("data/olist_sellers_dataset.csv")

customers.to_sql('customers', engine, schema='raw', if_exists='replace', index=False)
geolocation.to_sql('geolocation', engine, schema='raw', if_exists='replace', index=False)
order_items.to_sql('order_items', engine, schema='raw', if_exists='replace', index=False)
order_payments.to_sql('order_payments', engine, schema='raw', if_exists='replace', index=False)
order_reviews.to_sql('order_reviews', engine, schema='raw', if_exists='replace', index=False)
orders.to_sql('orders', engine, schema='raw', if_exists='replace', index=False)
products.to_sql('products', engine, schema='raw', if_exists='replace', index=False)
sellers.to_sql('sellers', engine, schema='raw', if_exists='replace', index=False)