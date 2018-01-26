require 'rails_helper'

feature 'User signs recipes' do
  scenario 'successfully' do
    user = create(:user)
    other_user = create(:user, email: 'joao@email.com', name: 'joao')
    cuisine = create(:cuisine)
    recipe_type = create(:recipe_type)
    other_recipe = create(:recipe, title: 'Sushi', cuisine: cuisine,
                                   recipe_type: recipe_type, user: other_user)

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password

    within('div.actions') do
      click_on 'Entrar'
    end

    within('nav.menu') do
      click_on 'Enviar uma receita'
    end

    fill_in 'Título', with: 'Temaki'
    select recipe_type.name, from: 'Tipo da Receita'
    select cuisine.name, from: 'Cozinha'
    fill_in 'Dificuldade', with: 'Facil'
    fill_in 'Tempo de Preparo', with: '50'
    fill_in 'Ingredientes', with: 'Salmão, Arroz e Alga'
    fill_in 'Como Preparar', with: 'Enrola tudo'

    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Temaki')
    expect(page).to have_css('h3', text: 'Detalhes')
    expect(page).to have_css('p', text: recipe_type.name)
    expect(page).to have_css('p', text: cuisine.name)
    expect(page).to have_css('p', text: 'Facil')
    expect(page).to have_css('p', text: '50 minutos')
    expect(page).to have_css('h3', text: 'Ingredientes')
    expect(page).to have_css('p', text: 'Salmão, Arroz e Alga')
    expect(page).to have_css('h3', text: 'Como Preparar')
    expect(page).to have_css('p', text:  'Enrola tudo')
    expect(page).to have_css('h3', text: 'Autor')
    expect(page).to have_css('p', text: user.name)
    expect(page).not_to have_content(other_recipe.title)
    expect(page).not_to have_content(other_user.name)
  end
end
