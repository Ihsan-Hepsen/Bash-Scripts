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
