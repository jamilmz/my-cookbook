class CuisinesController < ApplicationController
  before_action :set_aside_variables, only: [:index, :show, :new, :edit]
  before_action :authenticate_user!, only: [:new, :create]
  before_action :set_find_cuisine, only: [:show, :edit, :update]

  def index
    @cuisines = Cuisine.all
  end

  def show
    @recipes = Recipe.where(cuisine_id: params[:id])
  end

  def new
    @cuisine = Cuisine.new
  end

  def create
    @cuisine = Cuisine.new(cuisine_params)

    if @cuisine.save
      redirect_to @cuisine
    else
      set_aside_variables
      flash.now[:error] = 'Você deve informar o nome da cozinha'
      render :new
    end
  end

  def edit() end

  def update
    if @cuisine.update(cuisine_params)
      redirect_to @cuisine
    else
      set_aside_variables
      flash.now[:error] = 'Você deve informar todos os dados da receita'
      render :edit
    end
  end

  private

  def cuisine_params
    params.require(:cuisine).permit(:name)
  end

  def set_aside_variables
    @cuisines = Cuisine.all
    @recipe_types = RecipeType.all
  end

  def set_find_cuisine
    @cuisine = Cuisine.find(params[:id])
  end
end
