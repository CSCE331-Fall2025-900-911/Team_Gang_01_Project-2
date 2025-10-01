# Database Population

This document goes over the procedure to populate the database.

### Prerequisites
Python 3.8 or greater is required to run the database seeding script. No external dependencies are required. Get Python from [python.org/downloads](https://www.python.org/downloads/).

A PostgreSQL database is required. There are a few ways to get PostgreSQL
- From [https://www.postgresql.org/download/](https://www.postgresql.org/download/). This will come with the PSQL command line utility which is required for this program.
- Via Docker: see [this post by Docker](https://www.docker.com/blog/how-to-use-the-postgres-docker-official-image/) for a guide on how to use Docker to set up a PostgreSQL container.
  - The PSQL command line utility will need to be installed separately.

If you already have a database, make sure you have the database connection string in the following format:
```
postgresql://<user>:<pass>@<host>:<port>/<db>
```

### Setup 
First, you'll need to connect to your database using `psql` and create the necessary tables. Use the following command:
```
$ psql $DB_URL -f create_tables.sql
```
Substitute `$DB_URL` for your database connection string.

Then, run the Python script to generate the the CSV files:
```
$ py main.py
```
On Windows, or:
```
$ python main.py
```
on Linux/MacOS

The 7 CSV files must be imported in a specific order:
1. `employees.csv`
2. `categories.csv`
3. `ingredients.csv`
4. `menu.csv`
5. `orders.csv`
6. `drink_orders.csv`
7. `drink_ingredients.csv`

CSV files can be imported with `psql` using the following command:
```
$ psql $DB_URL -c "\COPY <table_name> FROM <filename>.csv WITH CSV HEADER;"
```

To facilitate this process, a bash script file, `load_csv.sh`, has been provided. Ensure the shell file is executable, then run it:
```
$ chmod 755 load_csv.sh
$ ./load-csv.sh $DB_URL
```

The database will now be populated.

### SQL Files
There are three SQL files provided to manage database schema population and cleanup.
- `create_tables.sql`: Sequence of SQL queries to set up the necessary tables.
- `clear_tables.sql`:  Sequence of SQL queries that delete all records across all tables, leaving behind empty tables.
- `delete_tables.sql`: Sequence of SQL queries that delete all records and tables.

These files can all be run using the same command that was used for `create_tables.sql`:
```
$ psql $DB_URL -f <create,clear,delete>_tables.sql
```

### CSV Files
There are 4 CSV files that are required to be in the current working directory. These CSV files are **NOT** dynamically generated, and as such, are included in this repository.
- `employees.csv`
- `cateegories.csv`
- `ingredients.csv`
- `menu.csv`

After running `main.py`, 3 more CSV files will have generated:
- `orders.csv`
- `drink_orders.csv`
- `drink_ingredients.csv`

These 7 files together make up the content of the 7 tables in the database according to the following one-to-one mapping:
| File                  | Table              |
|-----------------------|--------------------|
| orders.csv            | orders             |
| employees.csv         | employees          |
| categories.csv        | categories         |
| menu.csv              | menu               |
| ingredients.csv       | ingredients        |
| drink_ingredients.csv | drinks_ingredients |
| drink_orders.csv      | drinks_orders      |
