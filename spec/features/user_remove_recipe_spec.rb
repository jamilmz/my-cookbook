require 'rails_helper'

feature 'User remove recipe' do
  scenario 'successfully' do
    user = create(:user)
    cuisine = create(:cuisine)
    recipe_type = create(:recipe_type)
    recipe = create(:recipe, user: user, cuisine: cuisine,
                             recipe_type: recipe_type)
    other_recipe = create(:recipe, title: 'Frango Teryaki', user: user,
                                   cuisine: cuisine,
                                   recipe_type: recipe_type)

    visit root_path

    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password

    within('div.actions') do
      click_on 'Entrar'
    end

    click_on recipe.title
    click_on 'Remover'

    expect(page).not_to have_content recipe.title
    expect(page).to have_link other_recipe.title
  end
end
