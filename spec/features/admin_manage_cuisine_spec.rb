require 'rails_helper'

feature 'admin manage cuisine' do
  scenario 'successfully' do
    admin = create(:user, admin: true)

    login_as(admin)

    visit root_path

    click_on 'Cozinhas'
    click_on 'Nova cozinha'

    fill_in 'Nome', with: 'Brasileira'
    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Brasileira')
    expect(page).to have_content('Nenhuma receita encontrada para este tipo '\
                                 'de cozinha')
  end

  scenario 'user cant user new cuisine button' do
    user = create(:user)
    login_as(user)

    visit root_path

    expect(page).not_to have_link('Cozinhas')
  end

  scenario 'admin can edit the recipe' do
    admin = create(:user, admin: true)
    cuisine = create(:cuisine)

    login_as(admin)
    visit root_path

    click_on 'Cozinhas'

    within('div.cuisine-list') do
      click_on cuisine.name
    end

    click_on 'Editar'

    fill_in 'Nome', with: 'Russa'
    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Russa')
    expect(page).to have_content('Nenhuma receita encontrada para este tipo '\
                                 'de cozinha')
  end

  scenario 'admin must update correctly' do
    admin = create(:user, admin: true)
    cuisine = create(:cuisine)

    login_as(admin)
    visit root_path

    click_on 'Cozinhas'

    within('div.cuisine-list') do
      click_on cuisine.name
    end

    click_on 'Editar'

    fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Você deve informar todos os dados da receita')
  end

  scenario 'only admin can see edit button' do
    user = create(:user)
    cuisine = create(:cuisine)

    login_as(user)
    visit root_path

    click_on cuisine.name

    expect(page).not_to have_link('Editar')
  end
end
