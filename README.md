Definition keyspace for DSE :

```sql
CREATE KEYSPACE IF NOT EXISTS mykeyspace 
WITH REPLICATION = {'class' : 'NetworkTopologyStrategy', 'DC1' : 1;
```

Definition tables for DSE :

```sql
CREATE TYPE IF NOT EXISTS "mykeyspace".adresse_udt (
   address_name text,
   street       text,
   locality     text,
   region       text,
   zipcode      text,
   country      text
);

CREATE TABLE IF NOT EXISTS "mykeyspace"."user" (
  "user_id"   uuid,
  "first_name"    text,
  "last_name"     text,
  "gender"        text,
  "username"      text,
  "email_address" text,
  "home_phone"    text,
  "mobile_phone"  text,
  "created_on"    timestamp,
  "register_date" timestamp,
  "addresses"     set<frozen<aurabute.adresse_udt>>,
  PRIMARY KEY ("user_id")
);

``` 

Install Fakeit :

https://github.com/bentonam/fakeit

For model generation use this command line :

```bash
fakeit folder 'models' '*'
```

For inserting data to DSE use dsbulk tool :

```bash
dsbulk load -url * -k mykeyspace -t user -h '127.0.0.1' -c json
```