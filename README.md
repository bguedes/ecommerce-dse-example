## Ecommerce DSE Example



### Definition keyspace for DSE

You can find cassandra keyspace definition in data/cql/aurabute_schema.cql. Run it using cqlsh.

### Install Fakeit

https://github.com/bentonam/fakeit

### Generate fake data 

For model generation use this command line:

```bash
# to generate json
fakeit folder 'aurabute_e_commerce' --count 10000 'data/models/' --verbose
```

It will create a folder named aurabute with generated json objects or csv inside. 

### Run and feed DSE 

Docker and docker-compose are required to run the cluster.

#### Run the cluster
In docker-compose folder run this commands:
```bash
# In docker-compose folder run this command to download images and start containers 
# change node=2 if more nodes needed
docker-compose -f docker-compose.yml -f docker-compose.opscenter.yml up -d --scale node=2
```

Then you will be able to retrieve seed node ip: 
```bash
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' docker-compose_seed_node_1
```

#### Run schema definition
Use this ip to load cql script to generate e-commerce schema:
```bash
cqlsh node_ip -f ../data/cql/aurabute_schema.cql
```

#### Inject data
And finaly you will inject you generated data into DSE using dsbulk tool:

```bash
dsbulk load -url 'aurabute_e_commerce/' -k aurabute -t user -h 'node_ip' -c json --connector.json.fileNamePattern "**user*"
dsbulk load -url 'aurabute_e_commerce/' -k aurabute -t product -h 'node_ip' -c json --connector.json.fileNamePattern "**product*"
dsbulk load -url 'aurabute_e_commerce/' -k aurabute -t order -h 'node_ip' -c json --connector.json.fileNamePattern "**order*"
```