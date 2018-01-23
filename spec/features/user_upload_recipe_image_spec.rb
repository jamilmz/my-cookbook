require 'rails_helper'

feature 'user upload recipe image' do
  scenario 'succesfully' do
    user = create(:user)
    cuisine = create(:cuisine, name: 'Arabe')
    recipe_type = create(:recipe_type, name: 'Entrada')

    login_as(user)

    visit root_path
    click_on 'Enviar uma receita'

    fill_in 'Título', with: 'Tabule'
    select recipe_type.name, from: 'Tipo da Receita'
    select cuisine.name, from: 'Cozinha'
    fill_in 'Dificuldade', with: 'Fácil'
    fill_in 'Tempo de Preparo', with: '45'
    fill_in 'Ingredientes',
            with: 'Trigo para quibe, cebola, tomate picado, azeite, salsinha'
    fill_in 'Como Preparar',
            with: 'Misturar tudo e servir. Adicione limão a gosto.'

    page.attach_file('Foto', Rails.root + 'spec/support/bolo.jpeg')
    click_on 'Enviar'

    expect(page).to have_css("img[src*='bolo.jpeg']")
  end
end
