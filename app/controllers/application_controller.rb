class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_aside_variables

  def set_aside_variables
  	@cuisines_all = Cuisine.all
  	@recipe_types_all = RecipeType.all
  end

end
