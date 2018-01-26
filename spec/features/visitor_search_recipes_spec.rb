require 'rails_helper'

feature 'Visitor search for recipes' do
  scenario 'from home page' do
    # cria os dados necessarios previamente
    user = create(:user)
    cuisine = create(:cuisine)
    recipe_type = create(:recipe_type)
    another_recipe_type = create(:recipe_type, name: 'Sobremesa')
    recipe = create(:recipe, user: user, cuisine: cuisine,
                             recipe_type: recipe_type)
    another_recipe = create(:recipe, title: 'Frango Teryaki', user: user,
                                     cuisine: cuisine,
                                     recipe_type: another_recipe_type)

    # simula a acao do usuario
    visit root_path
    fill_in 'Busca', with: recipe.title
    click_on 'Buscar'

    # expectativas do usuario apos a acao
    expect(page).to have_css('h1',
                             text: "Resultado da busca por: #{recipe.title}")
    expect(page).to have_css('h1', text: recipe.title)
    expect(page).to have_css('li', text: recipe.recipe_type.name)
    expect(page).to have_css('li', text: recipe.cuisine.name)
    expect(page).to have_css('li', text: recipe.difficulty)
    expect(page).to have_css('li', text: "#{recipe.cook_time} minutos")
    expect(page).not_to have_css('h1', text: another_recipe.title)
  end

  scenario 'and navigate to recipe details' do
    # cria os dados necessarios previamente
    recipe = create(:recipe)

    # simula a acao do usuario
    visit root_path
    fill_in 'Busca', with: recipe.title
    click_on 'Buscar'
    click_on recipe.title

    # expectativas do usuario apos a acao
    expect(current_path).to eq(recipe_path(recipe))
  end
end
