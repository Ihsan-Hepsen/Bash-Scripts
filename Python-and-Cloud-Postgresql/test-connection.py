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
