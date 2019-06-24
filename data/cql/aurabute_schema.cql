
CREATE KEYSPACE IF NOT EXISTS "aurabute" WITH replication = {'class': 'NetworkTopologyStrategy', 'dc1':'2'};

USE "aurabute";

-- Create UDT
CREATE TYPE IF NOT EXISTS "aurabute".address (
  "address_name" text,
  "street" text,
  "locality" text,
  "region" text,
  "zipcode" text,
  "country" text
);

CREATE TYPE IF NOT EXISTS "aurabute".item (
  "product_id" text,
  "display_name" text,
  "image" text,
  "price" double,
  "qty" int,
  "sub_total" double
);

-- User table
CREATE TABLE IF NOT EXISTS "aurabute"."user" (   
  "user_id" uuid,   
  "first_name" text,   
  "last_name" text,   
  "gender" text,   
  "username" text,   
  "email_address" text,   
  "home_phone" text,   
  "mobile_phone" text,   
  "created_on" timestamp,   
  "addresses" list<frozen<address>>,   
  PRIMARY KEY ("user_id")
);

-- Product table
CREATE TABLE IF NOT EXISTS "aurabute"."product" (
  "sku" int,
  "product_id" uuid,
  "price" double,
  "sale_price" double,
  "display_name" text,
  "description_short" text,
  "description_long" text,
  "stock" int,
  "category" text,
  "image" text,
  "created_on" timestamp,
  "modified_on" timestamp,
  PRIMARY KEY ("product_id", "created_on")
)
WITH CLUSTERING ORDER BY ("created_on" DESC);

-- Order table
CREATE TABLE IF NOT EXISTS "aurabute"."order" (
  "order_id" uuid,
  "user_id" uuid,
  "order_date" timestamp,
  "order_status" text,
  "line_items" list<frozen<item>>,
  "total_price" double,
  "billing_address" frozen<address>,
  "shipping_address" frozen<address>,
  "shipping_price" double,
  PRIMARY KEY (("user_id"), "order_date")
)
WITH CLUSTERING ORDER BY ("order_date" DESC);

-- Order by user table
CREATE TABLE IF NOT EXISTS "aurabute"."order_by_user" (
  "order_id" uuid,
  "user_id" uuid,
  "order_date" timestamp,
  "order_status" text,
  "line_items" list<frozen<item>>,
  "total_price" double,
  "billing_address" frozen<address>,
  "shipping_address" frozen<address>,
  "user_gender" text,
  "user_first_name" text,
  "user_last_name" text,
  PRIMARY KEY ("user_id", "order_date")
)
WITH CLUSTERING ORDER BY ("order_date" DESC);


