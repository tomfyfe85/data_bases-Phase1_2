```ruby


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

INSERT INTO students (name, cohort_name) VALUES ('David', 'April 2022');
INSERT INTO students (name, cohort_name) VALUES ('Anna', 'May 2022');
Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.
```
psql -h 127.0.0.1 your_database_name < seeds_{table_name}.sql
```ruby
3. Define the class names
Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by Repository for the Repository class name.


# EXAMPLE
# Table name: artists

# Model class
# (in lib/artists.rb)
class Artist
# Selecting all records
# No arguments
end

# Repository class
# (in lib/artist_repository.rb)
class ArtistRepository

  def all
    # Executes the SQL query 
    # SELECT id, name, genre FROM artists;
  end 

# select a single record 
# given the id in argument (a number) 

  def find(id)
#SELECT id, name, genre FROM artists WHERE id = $'<number of id you'd like to find>'
#returns a single artist from object
  end 

  def create(artist)
   # excutes SQL query;
   # INSERT INTO artits (name, genre) VALUES($1, $2);
   # Doesn't need to return any thing (only creates the record)
  end 

# Deletes artist record
  def delete(id)
  # Executes the SQL
  # DELETE FROM artists WHERE id = $1

  # Returns nothing (only deletes the record)
  end 
 
 # updates an artist record
 #Takes an Artist object (with the updated fields)
  def update(artist)
   # executes SQL 
   # UPDATE artists SET name = $1, genre = $2 WHERE id = $3
   # returns nothing (only updates records, write operation - only changes state)
  end
end

4. Implement the Model class
Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

# EXAMPLE
# Table name: students

# Model class
# (in lib/student.rb)

class Artist

  # Replace the attributes by your own columns.
  attr_accessor :id, :name, genre:
end


# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
# here's an example:
#
# student = Student.new
# student.name = 'Jo'
# student.name
You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.

5. Define the Repository Class interface
Your Repository class will need to implement methods for each "read" or "write" operation you would like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.


# EXAMPLE
# Table name: artists

# Repository class
# (in lib/student_repository.rb)

class ArtistRepository

  def all
    # Executes the SQL query 
    # SELECT id, name, genre FROM artists;
  end 

# select a single record 
# given the id in argument (a number) 

  def find(id)
#SELECT id, name, genre FROM artists WHERE id = $'<number of id you'd like to find>'
#returns a single artist from object
  end 

  def create(artist)
   # excutes SQL query;
   # INSERT INTO artits (name, genre) VALUES($1, $2);
   # Doesn't need to return any thing (only creates the record)
  end 

# Deletes artist record
  def delete(id)
  # Executes the SQL
  # DELETE FROM artists WHERE id = $1

  # Returns nothing (only deletes the record)
  end 
 
 # updates an artist record
 #Takes an Artist object (with the updated fields)
  def update(artist)
   # executes SQL 
   # UPDATE artists SET name = $1, genre = $2 WHERE id = $3
   # returns nothing (only updates records, write operation - only changes state)
  end
end

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
artists.first.name # => 'Pixies'

# 2
# Get a single artist
repo = ArtistRepository.new
artist = repo.find(1)

artist.id # => 1
artist.name # =>  'Pixies'
artist.genre # =>  'Rock'

#3
# get another single artist 
repo = ArtistRepository.new
artist = repo.find(2)

artist.id # => 2
artist.name # => 'ABBA'
artist.genre # => 'Pop

#4 
# To create a new artist
repo = ArtistRosposity.new 

artist = Artist.new 
artist.name = 'Beatles'
artist.genre = 'Pop'

repo.create(artist) # => nil

artists = repo.all #search through all columns 

last_artist = artists.last
last_artist.name # => 'Beatles'
last_artist.genre # => 'Pop'

#5
#DELETE
repo = ArtistRepository.new

id_to_delete = 1

repo.delete(id_to_delete) # deletes at id eg, id 1

all_artists = repo.all # calls  all 
all_artists.length # => 1
all_artiists.id # => 2

#6 
#UPDATE
repo = AtristRepository.new 

artist = repo.find(1)

artist.name = 'NeW NAmE'
artist.genre = 'Disco'
repo.update(artist)

# use find to get the updated table

find_artist = artist.find(1)
find_artist.name # => "NeW NAmE"
find_artist.genre # => 'Disco'
 


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