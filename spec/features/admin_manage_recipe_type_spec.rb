require 'rails_helper'

feature 'admin manage recipe type' do
  scenario 'successfully' do
    admin = create(:user, admin: true)

    login_as(admin)

    visit root_path

    click_on 'Tipos de Receita'
    click_on 'Novo tipo de receita'

    fill_in 'Nome', with: 'Ceia'
    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Ceia')
  end

  scenario 'user cant user new recipe type button' do
    user = create(:user)
    login_as(user)

    visit root_path

    expect(page).not_to have_link('Tipos de Receita')
  end

  scenario 'admin can edit the recipe type' do
    admin = create(:user, admin: true)
    recipe_type = create(:recipe_type)

    login_as(admin)
    visit root_path

    click_on 'Tipos de Receita'

    within('div.recipe-type-list') do
      click_on recipe_type.name
    end

    click_on 'Editar'

    fill_in 'Nome', with: 'Ceia'
    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Ceia')
  end

  scenario 'admin must update correctly' do
    admin = create(:user, admin: true)
    recipe_type = create(:recipe_type)

    login_as(admin)
    visit root_path

    click_on 'Tipos de Receita'

    within('div.recipe-type-list') do
      click_on recipe_type.name
    end

    click_on 'Editar'

    fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Você deve informar o nome do tipo de receita')
  end

  scenario 'only admin can see edit button' do
    user = create(:user)
    recipe_type = create(:recipe_type)

    login_as(user)
    visit root_path

    click_on recipe_type.name

    expect(page).not_to have_link('Editar')
  end
end
