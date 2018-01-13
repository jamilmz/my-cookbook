require 'rails_helper'

feature 'User sign in' do
  scenario 'successfully' do
    user = User.create(email: 'jamil@gmail.com', password: '12345678')

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password

    within('div.actions') do
      click_on 'Entrar'
    end

    expect(page).to have_content("Bem-vindo #{user.email} ao maior livro de receitas online")
    expect(page).not_to have_link('Entrar')
  end
end
