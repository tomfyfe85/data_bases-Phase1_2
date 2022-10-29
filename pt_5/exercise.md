# Two Tables Design Recipe Template

_Copy this recipe template to design and create two related database tables from a specification._

## 1. Extract nouns from the user stories or specification

<!-- ```
As a coach
So I can get to know all students
I want to see a list of students' names.

As a coach
So I can get to know all students
I want to see a list of cohorts' names.

As a coach
So I can get to know all students
I want to see a list of cohorts' starting dates.

As a coach
So I can get to know all students
I want to see a list of students' cohorts.
``` -->

<!-- ```
Nouns: Students, names, cohorts, cohort start_date, students_cohort


```
Nouns; sheduled concerts, artist name, concert date, venue name, venue capacity

## 2. Infer the Table Name and Columns

Put the different nouns in this table. Replace the example with your own nouns.

| Record                | Properties          |
| --------------------- | ------------------  |
| Students              |  student name, student cohort
| Cohorts               | cohort name, cohort start date 



Remember to **always** have the primary key `id` as a first column. Its type will always be `SERIAL`.

```
# EXAMPLE:

Table: students
id: SERIAL
student_name text
student_cohort text

Table: Cohorts
id: SERIAL
cohort_name text
cohort_start int
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

1. Can one student have many cohorts? no
2. Can one cohort have many students? yes

-> Therefore,
-> An artist HAS MANY albums
-> An album BELONGS TO an artist

-> Therefore, the foreign key is on the albums table. FOREIGN KEY - (concerts) - 'venue id'
```                                                   Foreign key - (students) - 'cohort id'

*If you can answer YES to the two questions, you'll probably have to implement a Many-to-Many relationship, which is more complex and needs a third table (called a join table).*

## 4. Write the SQL.

```sql
-- EXAMPLE
-- file: albums_table.sql

-- Replace the table name, columm names and types.

-- Create the table without the foreign key first.
CREATE TABLE cohorts (
id: SERIAL PRIMARY KEY
cohort_name text
cohort_start int
);

-- Then the table with the foreign key 2nd.
CREATE TABLE students (
  id SERIAL PRIMARY KEY,
  student_name text
student_cohort text

-- The foreign key name is always {cohort}_id
  cohort_id int,
  constraint fk_venue_232 foreign key(cohort_id)
    references cohort(id)
    on delete cascade 
);

```

## 5. Create the tables.

```bash
psql -h 127.0.0.1 database_name < albums_table.sql
```