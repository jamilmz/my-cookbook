require 'rails_helper'

feature 'User sign in' do
  scenario 'successfully' do
    user = create(:user)
    other_user = create(:user, email: 'joao@gmail.com')

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password

    within('div.actions') do
      click_on 'Entrar'
    end

    expect(page).to have_content("Bem-vindo #{user.email} ao maior livro
                                  de receitas online")
    expect(page).not_to have_link('Entrar')
    expect(page).not_to have_content("Bem-vindo #{other_user.email}
                                      ao maior livro de receitas online")
  end

  scenario 'user log out' do
    user = create(:user)

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password

    within('div.actions') do
      click_on 'Entrar'
    end
    click_on 'Sair'

    expect(page).to have_link('Entrar')
    expect(page).not_to have_link('Sair')
  end
end
