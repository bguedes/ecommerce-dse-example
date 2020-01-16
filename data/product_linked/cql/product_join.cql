CREATE KEYSPACE IF NOT EXISTS "join_test" WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 1};

-- User table
CREATE TABLE IF NOT EXISTS "join_test"."users" (   
  "user_id" uuid,   
  "first_name" text,   
  "last_name" text,   
  PRIMARY KEY ("user_id")
);

-- Product table
CREATE TABLE IF NOT EXISTS "join_test"."products" (
  "product_id" uuid,
  "sku" int,
  "price" double,
  "colour" text,
  PRIMARY KEY ("product_id")
);

-- Cart table
CREATE TABLE IF NOT EXISTS "join_test"."carts" (   
  "cart_id" uuid,   
  "cart_items" list<text>,  
  "user_id" uuid,
  PRIMARY KEY ("cart_id")
);
