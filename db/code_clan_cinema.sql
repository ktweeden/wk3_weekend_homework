DROP TABLE IF EXISTS tickets
DROP TABLE IF EXISTS films
DROP TABLE IF EXISTS customers

CREATE TABLE customers (
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255),
  funds INT4
)

CREATE TABLE films (
  id SERIAL8 PRIMARY KEY,
  title VARCHAR(255),
  funds INT4
)

CREATE TABLE tickets (
  id SERIAL8 PRIMARY KEY,
  customer_id INT4 REFERENCES customers,
  film_id INT4 REFERENCES customers,
  
)
