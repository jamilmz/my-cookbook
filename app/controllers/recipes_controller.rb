class RecipesController < ApplicationController
  def show
  	@recipe = Recipe.find(params[:id])
  end	

  def new
  	@recipe = Recipe.new
  end

  def create 
    @recipe = Recipe.new(recipe_params)

    if @recipe.save
      redirect_to @recipe
    else
      render 'new'
    end
  end

  private
    def recipe_params
      params.require(:recipe).permit(:title, :recipe_type, :cuisine_id, :difficulty, :cook_time, :ingredients, :method)
    end
end
