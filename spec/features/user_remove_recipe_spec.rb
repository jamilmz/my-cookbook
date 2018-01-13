require 'rails_helper'

feature 'User remove recipe' do
  scenario 'successfully' do
    cuisine = Cuisine.create(name: 'Japonesa')
    recipe_type = RecipeType.create(name: 'Prato Principal')

    recipe = Recipe.create(title: 'Temaki', recipe_type: recipe_type,
                          cuisine: cuisine, difficulty: 'Médio',
                          cook_time: 50,
                          ingredients: 'Alga, Salmão, Arroz',
                          method: 'Enrolar tudo em cima de uma tabua')

    visit root_path
    click_on recipe.title
    click_on 'Remover'

    expect(page).not_to have_content recipe.title

  end
end
