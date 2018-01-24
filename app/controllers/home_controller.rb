class HomeController < ApplicationController
  before_action :set_aside_variables, only: [:index]

  def index
    @recipes = Recipe.last(6)
    @favorite_recipes = []

    favorites = Favorite.group(:recipe_id).count.sort.reverse.to_h
    favorites.each_key do |f|
      @favorite_recipes << Recipe.find(f)
    end
    @favorite_recipes = @favorite_recipes.first(3)
  end

  def set_aside_variables
    @cuisines = Cuisine.all
    @recipe_types = RecipeType.all
  end
end
