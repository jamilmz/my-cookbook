require 'rails_helper'

feature 'user sees latest recipes at home' do
  scenario 'the last 6' do
    user = create(:user)

    cuisine = create(:cuisine)
    recipe_type = create(:recipe_type)

    recipe = create(:recipe, user: user, title: 'Camarão a milanesa',
                    cuisine: cuisine, recipe_type: recipe_type)
    recipes = create_list(:recipe, 6, cuisine: cuisine,
                    recipe_type: recipe_type, user: user)

     login_as(user)
     visit root_path

     expect(page).not_to have_link recipe.title
     expect(page).to  have_selector('div.recipe', count: 6)

  end

  scenario 'sees all recipes' do
    user = create(:user)
    cuisine = create(:cuisine)
    recipe_type = create(:recipe_type)
    recipes = create_list(:recipe, 10, cuisine: cuisine,
    recipe_type: recipe_type, user: user)

    login_as(user)
    visit root_path

    click_on 'Visualizar todas receitas'

    expect(page).to have_selector('div.recipe', count: 10)
  end
end
