require 'rails_helper'

feature 'User sends a recipe by email' do
  scenario 'successfully' do
    user = create(:user)
    recipe = create(:recipe, user: user)

    login_as(user)
    visit root_path

    click_on recipe.title

    fill_in 'Nome', with: 'Mika'
    fill_in 'Email', with: 'mika@gmail.com'
    fill_in 'Mensagem', with: 'Esta receita é muito boa, aproveite!'

    #expect(RecipesMailer).to receive(:share).with('Mika', 'mika@gmail.com',
    #                                              'Esta receita é muito boa, aproveite!',
    #                                              recipe.id).and_call_original
    click_on 'Enviar'

    expect(current_path).to eq recipe_path(recipe)
    expect(page).to have_content('Receita compartilhada com sucesso')
    expect(page).not_to have_content('Falha ao enviar e-mail')
  end
end
