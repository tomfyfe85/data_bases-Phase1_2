# Artist Model and Repository Classes Design Recipe
Copy this recipe template to design and implement Model and Repository classes for a database table.

# 1. Design and create the Table
If the table is already created in the database, you can skip this step.

# Otherwise, follow this recipe to design and create the SQL schema for your table.

# In this template, we'll use an example table students

# # EXAMPLE

# Table: students

# Columns:
# id | name | cohort_name
2. Create Test SQL seeds
Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

-- EXAMPLE
-- (file: spec/seeds_{table_name}.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE students RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

```sql
TRUNCATE TABLE albums RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO albums (title, release_year) VALUES ('Doolittle', '1988');
INSERT INTO albums (title, release_year) VALUES ('Waterloo', '3030'); 
psql -h 127.0.0.1 your_database_name < seeds_{table_name}.sql


3. Define the class names
Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by Repository for the Repository class name.
```
```ruby 
# EXAMPLE
# Table name: albums

# Model class
# (in lib/albums.rb)
# class Artist
# end

# # Repository class
# # (in lib/album_repository.rb)
# class AlbumRepository
# Model
class Recipe
end 

#Repository 

class RecipeRepo
end

4. Implement the Model class
Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

# EXAMPLE
# Table name: students

# Model class
# (in lib/album.rb)

class Album

  # Replace the attributes by your own columns.
  attr_accessor :id, :title, :release_year
end 

class Recipe

  attr_accessor :id, :name, :av_cooking_time_mins, :rating
end

# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
# here's an example:
#
# album = Student.new
# album.name = 'Jo'
# album.name
You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.

5. Define the Repository Class interface
Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

# EXAMPLE
# Table name: artists

# Repository class
# (in lib/student_repository.rb)

class ArtistRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, name, genre FROM artists;

    # Returns an array of Artist objects. (model class)
  end

  # end
end
```
```ruby
#table name:recipes
class RecipeRepo
 #


# Rec

6. Write Test Examples
Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

# EXAMPLES

# 1
# Get all Artists 

repo = ArtistRepository.new

artists = repo.all
artist.length #=> 
artists.first.id # => '1'
artists.find.name # => 'Pixies'

# 2
# Get a single album

repo = StudentRepository.new

album = repo.find(1)

album.id # =>  1
album.name # =>  'David'
album.cohort_name # =>  'April 2022'

# Add more examples for each method
Encode this example as a test.

7. Reload the SQL seeds before each test run
Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

# EXAMPLE

# file: spec/student_repository_spec.rb

def reset_students_table
  seed_sql = File.read('spec/seeds_students.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'students' })
  connection.exec(seed_sql)
end

describe StudentRepository do
  before(:each) do 
    reset_students_table
  end

  # (your tests will go here).
end
8. Test-drive and implement the Repository class behaviour

```