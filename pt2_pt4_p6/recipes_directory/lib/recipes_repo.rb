require_relative '../lib/recipes'

class RecipesRepo
  def all
    sql = 'SELECT id, name, av_cooking_time_mins, rating FROM recipes;'
    result_set = DatabaseConnection.exec_params(sql, [])
    recipes_array = []


    result_set.each do |record|
      recipes = Recipes.new
      recipes.id = record['id']
      recipes.name = record['name']
      recipes.av_cooking_time_mins = record['av_cooking_time_mins'].to_i
      recipes.rating = record['rating'].to_i

      recipes_array << recipes


    end 
    return recipes_array
  end   
  def find(id)
    sql = 'SELECT id, name, av_cooking_time_mins, rating FROM recipes WHERE id = $1;'
    params = [id]
    result_set = DatabaseConnection.exec_params(sql, params)

    record = result_set[0]
   
    recipes = Recipes.new
      recipes.id = record['id']
      recipes.name = record['name']
      recipes.av_cooking_time_mins = record['av_cooking_time_mins'].to_i
      recipes.rating = record['rating'].to_i

      return recipes
  end 
end 


