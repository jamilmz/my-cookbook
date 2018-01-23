require 'rails_helper'

feature 'User signs recipes' do
  scenario 'successfully' do
    user = User.create(email: 'jamil@gmail.com', password: '12345678',
                       name: 'Jamil')
    other_user = User.create(email: 'joao@email.com', password: '87654321',
                             name: 'Joao')
    cuisine = Cuisine.create(name: 'Japonesa')
    recipe_type = RecipeType.create(name: 'Prato Principal')
    other_recipe = Recipe.create(title: 'Sushi', cuisine: cuisine,
                                 recipe_type: recipe_type,
                                 user: other_user, difficulty: 'Media',
                                 cook_time: 50, ingredients: 'Arroz',
                                 method: 'Enrola tudo')

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
    select 'Prato Principal', from: 'Tipo da Receita'
    select 'Japonesa', from: 'Cozinha'
    fill_in 'Dificuldade', with: 'Facil'
    fill_in 'Tempo de Preparo', with: '50'
    fill_in 'Ingredientes', with: 'Salmão, Arroz e Alga'
    fill_in 'Como Preparar', with: 'Enrola tudo'

    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Temaki')
    expect(page).to have_css('h3', text: 'Detalhes')
    expect(page).to have_css('p', text: 'Prato Principal')
    expect(page).to have_css('p', text: 'Japonesa')
    expect(page).to have_css('p', text: 'Facil')
    expect(page).to have_css('p', text: '50 minutos')
    expect(page).to have_css('h3', text: 'Ingredientes')
    expect(page).to have_css('p', text: 'Salmão, Arroz e Alga')
    expect(page).to have_css('h3', text: 'Como Preparar')
    expect(page).to have_css('p', text:  'Enrola tudo')
    expect(page).to have_css('h3', text: 'Autor')
    expect(page).to have_css('p', text: 'Jamil')
    expect(page).not_to have_content(other_recipe.title)
    expect(page).not_to have_content(other_user.name)
  end
end
