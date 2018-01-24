class CuisinesController < ApplicationController
  before_action :set_aside_variables, only: [:show, :new]

  def show
    @cuisine = Cuisine.find(params[:id])
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

  private

  def cuisine_params
    params.require(:cuisine).permit(:name)
  end

  def set_aside_variables
    @cuisines = Cuisine.all
    @recipe_types = RecipeType.all
  end
end
