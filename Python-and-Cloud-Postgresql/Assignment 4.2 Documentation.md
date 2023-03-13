# 4.2 Python & Cloud Postgresql

# Table of Contents

### Student & Course Info

**Student name:** Ihsan Hepsen

**Student ID:** 0145029-14

**Course:** Infrastructure 2

**Week:** 4

### Before We Start

There are couple of tools/packages we need to install. You can install the necessary tools/packages as specified below.

```bash
# 1
sudo apt install python3-pip
# 2
pip install psycopg2
# 3a
sudo apt install postgresql-client-common
# 3b
sudo apt-get install postgresql-client
```

### Custom `new-sql-instance.sh` Script (Extra)

A script to create new gcloud sql instance was not a requirement, however I thought it could come in handy. You can find the scripts on my [google drive](https://drive.google.com/drive/folders/1-Nwl4dAecz83qSea-nU0QK5-AXzDTa2g?usp=sharing).

**Please note:** *This script  will only create Postgresql version 14 sql instances. Besides the sql dialect, the public IP address is found by executing `curl icanhazip.com` . The script excepts only one parameter;  name for the new sql instance.*

```bash
#!/bin/bash

if [ $# -eq 0 ]
then
	echo "Please provide a sql-instance name"
	exit 1
fi

gcloud sql instances create "${1}" --tier=db-g1-small --region=europe-west1 --authorized-networks=109.128.102.10/32 --database-version=POSTGRES_14
```

### Creating SQL instance

If you wish to create a sql instance without using the script above, it is possible to do so with the command provided below;

```bash
# First, create the sql instance
gcloud sql instances create w4-assignment \
 --tier=db-g1-small \
 --region=europe-west1 \
 --database-version=POSTGRES_14

# optionally, you can set authorized IP addresses or you can do it later
gcloud sql instances patch w4-assignment \ 
--authorized-networks=109.128.102.10/32
```

After installing all the required tools and packages I started with the assignment. First things first, I created the new sql instance which uses Postgresql v14 as its sql dialect.

```bash
# I wrote a small script that creates an Postgresql(14) sql instance
# The script takes care of the public IP address and Postgresql version
# simply pass in a name for the new sql instance
./new-sql-instance.sh 'w4-assignmnet'
```

### Creating Database & User

After creation of the sql instance ‘w4-assignment’, I executed the following;

```bash
# database
gcloud sql databases create w4-db --instance=w4-assignment

# user
gcloud sql users create ihsan --instance=w4-assignment --password=aslankaplan123
```

### Testing Connection

After successfully creating a database and an user, it is time to test DB connection with the provided python code. After modifying the py script I have the following;

```bash
#!/usr/bin/python3

import psycopg2

# Open the database connection
conn = psycopg2.connect (
  dbname='w4-db',
  user='ihsan',
  password='aslankaplan123',
  host='34.140.22.49')

# Prepare a cursor object
cur = conn.cursor()

# Execute this SQL query to retrieve the Postgres version
cur.execute("SELECT VERSION()")

# Fetch a single row
data = cur.fetchone()
print("Connection established to: ", data)

# Close the connection
conn.close()
```

Let’s test our connection.

```bash
./test-connection.py 
# Response:
# Connection established to:  ('PostgreSQL 14.0 on x86_64-pc-linux-gnu, compiled by Debian clang version 12.0.1, 64-bit',)
```

Awesome! We have a successful connection.

### Creating Table & Inserting Data

At first I run the script without  modification and it worked successfully.

By modifying the provided python script template, I added one  `INSERT` statement.

```bash
#!/usr/bin/python3

import psycopg2

try:
  conn = psycopg2.connect (
    dbname='w4-db',
    user='ihsan',
    password='aslankaplan123',
    host='34.140.22.49')
except:
  print("I am unable to connect to the database.")

cur = conn.cursor()

cur.execute("DROP TABLE IF EXISTS employees")

sql="""CREATE TABLE employees (
  first_name VARCHAR(20) NOT NULL,
  last_name VARCHAR(20),
  age INT);

  INSERT INTO employees
  VALUES ('Rudo', 'Villano', 31);
"""

# Create the table
cur.execute(sql)

# Commit the changes
conn.commit()

# Close the connection
conn.close()
```

running the script.

```bash
./create-N-insert.py
```

The script run successfully.

### Authorized IP

**Please Note:**

Regarding to instruction “*Check if the Python script to insert data still works ok with the new authorized IP.*” Since I used the option `--authorized-networks=109.128.102.10/32` when I created the sql instance in the beginning, this step was already completed.

Regardless, you can always set authorized IP addresses to the sql instance.

```bash
curl i*canhazip.com
# 109.128.102.10*

gcloud sql instances patch w4-assignment \ 
--authorized-networks=109.128.102.10/32
```

All scripts still work.

**Important notice:** Every command, script, and execution have executed successfully with the authorized public IP address as specified both in the instruction sheet and in this document.

After performing all the instructions and having the desired results, I deleted the sql instance  as specified in the instruction sheet.

```bash
gcloud sql instances delete w4-assignment
```