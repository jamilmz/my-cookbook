class RecipesController < ApplicationController
  before_action :set_aside_variables, only: [:show, :new, :edit, :index,
                                             :my_favorites, :my_recipes]
  before_action :authenticate_user!, only: [:my_recipes, :new, :edit, :destroy,
                                            :favorite, :favorite,
                                            :delete_favorite]
  before_action :set_find_recipe, only: [:show, :edit, :update, :destroy,
                                         :favorite, :delete_favorite, :share]

  def index
    @recipes = Recipe.all
  end

  def show() end

  def new
    @recipe = Recipe.new
  end

  def edit
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
      flash[:notice] = 'Receita cadastrada com sucesso'
      redirect_to @recipe
    else
      set_aside_variables
      flash.now[:error] = 'Você deve informar todos os dados da receita'
      render :new
    end
  end

  def update
    if @recipe.update(recipe_params)
      redirect_to @recipe
    else
      set_aside_variables
      flash.now[:error] = 'Você deve informar todos os dados da receita'
      render :edit
    end
  end

  def destroy
    return false unless @recipe.destroy
    flash[:notice] = 'Receita deletada com sucesso'
    redirect_to root_path
  end

  def search
    @title = params[:search]
    @recipes = Recipe.where(title: @title)
  end

  def favorite
    @favorite = Favorite.new(user: current_user, recipe: @recipe)

    return false unless @favorite.save
    flash[:notice] = 'Receita favoritada com sucesso'
    redirect_to @recipe
  end

  def my_favorites
    @favorites = Favorite.where(user: current_user)
  end

  def delete_favorite
    @favorite = Favorite.find_by(user: current_user, recipe: @recipe)
    return false unless @favorite.destroy
    flash[:notice] = 'Receita removida dos favoritos'
    redirect_to @recipe
  end

  def my_recipes
    @recipes = Recipe.where(user: current_user)
  end

  def share
    name = params[:name]
    email = params[:email]
    message = params[:message]

    RecipesMailer.share(name, email, message, @recipe.id).deliver_now

    flash[:notice] = 'Receita compartilhada com sucesso'
    redirect_to @recipe
  end

  private

  def recipe_params
    params.require(:recipe).permit(:title, :recipe_type_id, :cuisine_id,
                                   :difficulty, :cook_time, :ingredients,
                                   :method, :image, :highlight)
  end

  def set_aside_variables
    @cuisines = Cuisine.all
    @recipe_types = RecipeType.all
  end

  def set_find_recipe
    @recipe = Recipe.find(params[:id])
  end
end
