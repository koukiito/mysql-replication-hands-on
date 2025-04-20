# mysql-replication-hands-on

## Usage

### Start the Docker containers

```bash
docker-compose up -d
```

### Execute queries to check the replication

#### In the master container

```bash
docker exec -it mysql-replication-hands-on_master mysql -u root -pmysql
```

```sql
use app;
SELECT * FROM sample_table;
```

#### In the slave container

```bash
docker exec -it mysql-replication-hands-on_slave mysql -u root -pmysql
```

```sql
use app;
SELECT * FROM sample_table;
```

#### Insert data into the master container

```bash
docker exec -it mysql-replication-hands-on_master mysql -u root -pmysql
```

```sql
use app;
INSERT INTO sample_table () VALUES ();
```

#### Check the data in the slave container

```bash
docker exec -it mysql-replication-hands-on_slave mysql -u root -pmysql
```

```sql
use app;
SELECT * FROM sample_table;
```
