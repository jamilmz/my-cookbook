class RecipesController < ApplicationController
before_action :set_aside_variables, only: [:show, :new, :edit]

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
    @recipe.user = current_user

    if @recipe.save
      redirect_to @recipe
    else
      set_aside_variables
      flash.now[:error] = "Você deve informar todos os dados da receita"
      render :new
    end
  end

  def update
    @recipe = Recipe.find(params[:id])

    if @recipe.update(recipe_params)
      redirect_to @recipe
    else
      set_aside_variables
      flash.now[:error] = "Você deve informar todos os dados da receita"
      render :edit
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])

    if @recipe.destroy
      redirect_to root_path
    else
      render :show
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

    def set_aside_variables
      @cuisines = Cuisine.all
      @recipe_types = RecipeType.all
    end
end
