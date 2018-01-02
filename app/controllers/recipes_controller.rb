class RecipesController < ApplicationController
  def show
  	@recipe = Recipe.find(params[:id])
  end	

  def new
  	@recipe = Recipe.new
  end

  def create 
  	title = params[:recipe][:title]
  	recipe_type = params[:recipe][:recipe_type]
    cuisine = params[:recipe][:cuisine]
    difficulty = params[:recipe][:difficulty]
    cook_time = params[:recipe][:cook_time]
    ingredients = params[:recipe][:ingredients]
    method = params[:recipe][:method]

    recipe = Recipe.new(title: title, recipe_type: recipe_type, cuisine: cuisine, difficulty: difficulty, cook_time: cook_time, ingredients: ingredients, method: method)
    recipe.save

    redirect_to recipe_path(recipe)
  end
end
