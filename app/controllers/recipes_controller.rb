class RecipesController < ApplicationController
  def show
  	@recipe = Recipe.find(params[:id])
  end	

  def new
  	@recipe = Recipe.new
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def create 
    @recipe = Recipe.new(recipe_params)

    if @recipe.save
      redirect_to @recipe
    else
      render 'new'
    end
  end

  def update
    @recipe = Recipe.find(params[:id])

    if @recipe.update(recipe_params)
      redirect_to @recipe
    else
      render 'edit'
    end
  end

  def search
    @title = params[:search]
    @recipes = Recipe.where(title: @title)
  end

  private
    def recipe_params
      params.require(:recipe).permit(:title, :recipe_type_id, :cuisine_id, :difficulty, :cook_time, :ingredients, :method)
    end
end
