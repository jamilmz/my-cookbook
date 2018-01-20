require 'rails_helper'

feature 'user marks recipe as highlight' do
  scenario 'successfully' do
    user = create(:user)
    cuisine = create(:cuisine)
    recipe_type = create(:recipe_type)

    login_as(user)
    visit root_path
    click_on 'Enviar uma receita'

    fill_in 'Título', with: 'Tabule'
    select cuisine.name, from: 'Cozinha'
    select recipe_type.name, from: 'Tipo da Receita'
    fill_in 'Dificuldade', with: 'Fácil'
    fill_in 'Tempo de Preparo', with: '45'
    fill_in 'Ingredientes', with: 'Trigo para quibe, cebola, tomate picado, azeite, salsinha'
    fill_in 'Como Preparar', with: 'Misturar tudo e servir. Adicione limão a gosto.'
    check 'Destaque'
    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Tabule')
    expect(page).to have_css('h3', text: 'Detalhes')
    expect(page).to have_css('p', text: cuisine.name)
    expect(page).to have_css('p', text: recipe_type.name)
    expect(page).to have_css('p', text: 'Fácil')
    expect(page).to have_css('p', text: "45 minutos")
    expect(page).to have_css('h3', text: 'Ingredientes')
    expect(page).to have_css('p', text: 'Trigo para quibe, cebola, tomate picado, azeite, salsinha')
    expect(page).to have_css('h3', text: 'Como Preparar')
    expect(page).to have_css('p', text:  'Misturar tudo e servir. Adicione limão a gosto.')
    expect(page).to have_css('figure.destaque')
  end


  scenario 'And can see in recipes listings' do
    user = create(:user)
    cuisine = create(:cuisine)
    recipe_type = create(:recipe_type)
    recipe = create(:recipe, cuisine: cuisine, recipe_type: recipe_type, user: user, highlight: true)

    login_as(user)
    visit root_path

    expect(page).to have_link recipe.title
    expect(page).to have_css('figure.destaque')
  end
end
