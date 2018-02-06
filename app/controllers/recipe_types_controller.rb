class RecipeTypesController < ApplicationController
  before_action :set_aside_variables, only: [:index, :show, :new, :edit]
  before_action :authenticate_user!, only: [:new, :create]
  before_action :set_find_recipe_type, only: [:show, :edit, :update]

  def index
    @recipe_types = RecipeType.all
  end

  def show
    @recipes = Recipe.where(recipe_type_id: params[:id])
  end

  def new
    @recipe_type = RecipeType.new
  end

  def create
    @recipe_type = RecipeType.new(recipe_type_params)

    if @recipe_type.save
      redirect_to @recipe_type
    else
      set_aside_variables
      flash.now[:error] = 'Você deve informar o nome do tipo de receita'
      render :new
    end
  end

  def edit() end

  def update
    if @recipe_type.update(recipe_type_params)
      redirect_to @recipe_type
    else
      set_aside_variables
      flash.now[:error] = 'Você deve informar o nome do tipo de receita'
      render :edit
    end
  end

  private

  def recipe_type_params
    params.require(:recipe_type).permit(:name)
  end

  def set_aside_variables
    @cuisines = Cuisine.all
    @recipe_types = RecipeType.all
  end

  def set_find_recipe_type
    @recipe_type = RecipeType.find(params[:id])
  end
end
