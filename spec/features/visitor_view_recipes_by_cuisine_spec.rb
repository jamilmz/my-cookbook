require 'rails_helper'

feature 'Visitor view recipes by cuisine' do
  scenario 'from home page' do
    # cria os dados necessarios previamente
    cuisine = create(:cuisine)
    recipe = create(:recipe, cuisine: cuisine)

    # simula a acao do usuario
    visit root_path
    click_on cuisine.name

    # expectativas do usuario apos a acao
    expect(page).to have_css('h1', text: cuisine.name)
    expect(page).to have_css('h1', text: recipe.title)
    expect(page).to have_css('li', text: recipe.recipe_type.name)
    expect(page).to have_css('li', text: recipe.cuisine.name)
    expect(page).to have_css('li', text: recipe.difficulty)
    expect(page).to have_css('li', text: "#{recipe.cook_time} minutos")
  end

  scenario 'and view only cuisine recipes' do
    # cria os dados necessarios previamente
    recipe = create(:recipe)
    cuisine = create(:cuisine, name: 'Italiana')
    recipe_type = create(:recipe_type, name: 'Prato Principal')
    other_recipe = create(:recipe, title: 'Macarrão Carbonara',
                                   cuisine: cuisine, recipe_type: recipe_type)

    # simula a acao do usuario
    visit root_path
    click_on cuisine.name

    # expectativas do usuario apos a acao
    expect(page).to have_css('h1', text: other_recipe.title)
    expect(page).to have_css('li', text: other_recipe.recipe_type.name)
    expect(page).to have_css('li', text: other_recipe.cuisine.name)
    expect(page).to have_css('li', text: other_recipe.difficulty)
    expect(page).to have_css('li', text: "#{other_recipe.cook_time} minutos")
    expect(page).not_to have_css('h1', text: recipe.title)
  end

  scenario 'and cuisine has no recipe' do
    # cria os dados necessarios previamente
    cuisine = create(:cuisine)
    other_cuisine = create(:cuisine, name: 'Italiana')
    recipe_type = create(:recipe_type)
    recipe = create(:recipe, recipe_type: recipe_type, cuisine: cuisine)

    # simula a acao do usuario
    visit root_path
    click_on other_cuisine.name

    # expectativas do usuario apos a acao
    expect(page).not_to have_content(recipe.title)
    expect(page).to have_content('Nenhuma receita encontrada para este
                                  tipo de cozinha')
  end
end
