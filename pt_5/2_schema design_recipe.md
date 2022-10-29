# Two Tables Design Recipe Template

_Copy this recipe template to design and create two related database tables from a specification._

## 1. Extract nouns from the user stories or specification

<!-- ```
# EXAMPLE USER STORY:
# (analyse only the relevant part - here the final line).

As a music lover,
So I can organise my records,
I want to keep a list of albums' titles.

As a music lover,
So I can organise my records,
I want to keep a list of albums' release years.

As a music lover,
So I can organise my records,
I want to keep a list of artists' names.

As a music lover,
So I can organise my records,
I want to know each album's artist.
``` -->

<!-- ```
Nouns:

album, title, release year, artist, name -->
```
Nouns; sheduled concerts, artist name, concert date, venue name, venue capacity

## 2. Infer the Table Name and Columns

Put the different nouns in this table. Replace the example with your own nouns.

| Record                | Properties          |
| --------------------- | ------------------  |
| concerts              | artist_name, sheduled_date
| venues                | venue_name, venue_cap

1. Name of the first table (always plural): `concerts'

    Column names: artist_name, sheduled_date

2. Name of the second table (always plural): `venues`

    Column names: venue_name venue_cap

## 3. Decide the column types.

[Here's a full documentation of PostgreSQL data types](https://www.postgresql.org/docs/current/datatype.html).

Most of the time, you'll need either `text`, `int`, `bigint`, `numeric`, or `boolean`. If you're in doubt, do some research or ask your peers.

Remember to **always** have the primary key `id` as a first column. Its type will always be `SERIAL`.

```
# EXAMPLE:

Table: concerts
id: SERIAL
artist_name text
sheduled date - timestamp

Table: venues
id: SERIAL
venue_name text
venue_cap int
```

## 4. Decide on The Tables Relationship

Most of the time, you'll be using a **one-to-many** relationship, and will need a **foreign key** on one of the two tables.

To decide on which one, answer these two questions:

1. Can one [concert] have many [venues]? (Yes/No)
2. Can one [venue] have many [concerts]? (Yes/No)

You'll then be able to say that:

1. **[A] has many [B]**
2. And on the other side, **[B] belongs to [A]**
3. In that case, the foreign key is in the table [B]

Replace the relevant bits in this example with your own:

```
# EXAMPLE

1. Can one artist have many albums? YES
2. Can one album have many artists? NO

-> Therefore,
-> An artist HAS MANY albums
-> An album BELONGS TO an artist

-> Therefore, the foreign key is on the albums table. FOREIGN KEY - (concerts) - 'venue id'
```

*If you can answer YES to the two questions, you'll probably have to implement a Many-to-Many relationship, which is more complex and needs a third table (called a join table).*

## 4. Write the SQL.

```sql
-- EXAMPLE
-- file: albums_table.sql

-- Replace the table name, columm names and types.

-- Create the table without the foreign key first.
CREATE TABLE venues (
  id SERIAL PRIMARY KEY,
  venue_name text,
  venue_cap int
);

-- Then the table with the foreign key 2nd.
CREATE TABLE concerts (
  id SERIAL PRIMARY KEY,
  artist_name text,
  sheduled_date timestamp,
-- The foreign key name is always {venue}_id
  venue_id int,
  constraint fk_venue_232 foreign key(venue_id)
    references venues(id)
    
);

```

## 5. Create the tables.

```bash
psql -h 127.0.0.1 database_name < albums_table.sql
```