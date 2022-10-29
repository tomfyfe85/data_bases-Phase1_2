require_relative 'lib/database_connection'

DatabaseConnection.connect('recipe_directory')

sql = 'SELECT id, name, av_cooking_time_mins, rating FROM recipes;'
result = DatabaseConnection.exec_params(sql, [])

result.each do |record|
  puts "RECIPES - #{record['id']} - #{record['name']} - #{record['av_cooking_time_mins']} - #{record['rating']}"

end 