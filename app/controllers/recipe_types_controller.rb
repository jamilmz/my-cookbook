class RecipeTypesController < ApplicationController
	def show
		@recipe_type = RecipeType.find(params[:id])
		@recipes = Recipe.where(recipe_type_id: params[:id])
	end
end