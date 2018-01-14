class RecipesController < ApplicationController
before_action :set_aside_variables, only: [:show, :new, :edit]
before_action :authenticate_user!, only: [:my_recipes, :new, :edit, :destroy,
              :new_favorite, :favorites, :remove_favorite]

  def index
    set_aside_variables
    @recipes = Recipe.all
  end

  def show
  	@recipe = Recipe.find(params[:id])
    @not_favorite = Favorite.where(user: current_user, recipe: @recipe).empty?
  end

  def new
  	@recipe = Recipe.new
  end

  def edit
    @recipe = Recipe.find(params[:id])
    if current_user == @recipe.user
      @recipe
    else
      redirect_to root_path
    end
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

  def new_favorite
    set_aside_variables

    @recipe = Recipe.find(params[:id])
    @favorite = Favorite.new(user: current_user, recipe: @recipe)

    if @favorite.save
      flash[:notice] = 'Receita favoritada com sucesso'
      redirect_to recipe_path(id: @recipe.id)
    else
      flash[:error] = 'Erro ao favoritar receita'
      redirect_to root_path
    end
  end

  def favorites
    set_aside_variables
    @favorites = Favorite.where(user: current_user)
  end

  def remove_favorite
    set_aside_variables
    @recipe = Recipe.find(params[:id])
    @favorite = Favorite.where(user: current_user, recipe: @recipe).take
    if Favorite.destroy(@favorite.id)
      flash[:notice] = 'Receita removida dos favoritos'
      redirect_to recipe_path(id: @recipe.id)
    else
      flash[:error] = 'Erro ao remover receita dos favoritos'
      redirect_to root_path
    end
  end

  def my_recipes
    set_aside_variables
    @recipes = Recipe.where(user: current_user)
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
