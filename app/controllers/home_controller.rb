class HomeController < ApplicationController
	before_action :set_aside_variables, only: [:index]

	def index
		@recipes = Recipe.last(6)
	end

	def set_aside_variables
		@cuisines = Cuisine.all
		@recipe_types = RecipeType.all
	end
end
