require_relative '../lib/recipes_repo'



def reset_recipes_table
  seed_sql = File.read('spec/seeds_recipe.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'recipe_directory_test'})
  connection.exec(seed_sql)
end 

RSpec.describe RecipesRepo do 

  before(:each) do 
    reset_recipes_table
  end 

  it 'returns the fist line of recipes list (minus id)' do 
    repo = RecipesRepo.new 
    recipes = repo.all

      expect(recipes[0].name).to eq('Pizza')
      expect(recipes[0].av_cooking_time_mins).to eq(15)
      expect(recipes[0].rating).to eq(10)
  end 


  it 'returns a single recipe from id = 1' do 
    repo = RecipesRepo.new
    recipes = repo.find(1)

      expect(recipes.name).to eq('Pizza')
      expect(recipes.rating).to eq(10)
  end 


# 3 it returns a single recipe from id = 2
  it 'returns a single recipe from id = 2' do 
   repo = RecipesRepo.new 
   recipe = repo.find(2)
    expect(recipe.name).to eq('Pancake')
    expect(recipe.av_cooking_time_mins).to eq(5)
  end 
end 