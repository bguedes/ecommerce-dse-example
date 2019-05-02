## Ecommerce DSE Example



### Definition keyspace for DSE

You can find cassandra keyspace definition in data/cql/aurabute_schema.cql. Run it using cqlsh.

### Install Fakeit

https://github.com/bentonam/fakeit

### Generate fake data 

For model generation use this command line:

```bash
fakeit folder 'aurabute_user' 'data/models/users.yaml'
fakeit folder 'aurabute_product' 'data/models/products.yaml'
fakeit folder 'aurabute_order' 'data/models/orders.yaml'
```

It will create a folder named aurabute with generated json objects inside. For inserting data to DSE use dsbulk tool:

```bash
dsbulk load -url 'aurabute_user' -k aurabute -t user -h '127.0.0.1' -c json
dsbulk load -url 'aurabute_product' -k aurabute -t product -h '127.0.0.1' -c json
dsbulk load -url 'aurabute_order' -k aurabute -t order -h '127.0.0.1' -c json
```