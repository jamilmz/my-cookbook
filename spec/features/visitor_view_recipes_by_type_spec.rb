
require 'rails_helper'

feature 'Visitor view recipes by type' do
  scenario 'from home page' do
    # cria os dados necessarios previamente
    recipe_type = create(:recipe_type)
    recipe = create(:recipe, recipe_type: recipe_type)

    # simula a acao do usuario
    visit root_path
    click_on recipe_type.name

    # expectativas do usuario apos a acao
    expect(page).to have_css('h1', text: recipe_type.name)
    expect(page).to have_css('h1', text: recipe.title)
    expect(page).to have_css('li', text: recipe.recipe_type.name)
    expect(page).to have_css('li', text: recipe.cuisine.name)
    expect(page).to have_css('li', text: recipe.difficulty)
    expect(page).to have_css('li', text: "#{recipe.cook_time} minutos")
  end

  scenario 'and view only recipes from same type' do
    # cria os dados necessarios previamente
    cuisine = create(:cuisine)
    recipe_type = create(:recipe_type)
    other_recipe_type = create(:recipe_type, name: 'rodizio')
    recipe = create(:recipe, cuisine: cuisine, recipe_type: recipe_type)
    other_recipe = create(:recipe, title: 'Churrascao', cuisine: cuisine,
                                   recipe_type: other_recipe_type)

    # simula a acao do usuario
    visit root_path
    click_on recipe_type.name

    # expectativas do usuario apos a acao
    expect(page).to have_css('h1', text: recipe.title)
    expect(page).not_to have_css('h1', text: other_recipe.title)
  end

  scenario 'and type has no recipe' do
    # cria os dados necessarios previamente
    cuisine = create(:cuisine)
    recipe_type = create(:recipe_type)
    recipe = create(:recipe, recipe_type: recipe_type, cuisine: cuisine)

    other_recipe_type = create(:recipe_type, name: 'Prato Principal')
    # simula a acao do usuario
    visit root_path
    click_on other_recipe_type.name

    # expectativas do usuario apos a acao
    expect(page).not_to have_content(recipe.title)
    expect(page).to have_content('Nenhuma receita encontrada para este tipo de
                                 receitas')
  end
end
