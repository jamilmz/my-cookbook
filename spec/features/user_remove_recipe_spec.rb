require 'rails_helper'

feature 'User remove recipe' do
  scenario 'successfully' do
    user = User.create(email: 'jamil@gmail.com', password: '12345678', name: 'Jamil')

    cuisine = Cuisine.create(name: 'Japonesa')
    recipe_type = RecipeType.create(name: 'Prato Principal')

    recipe = Recipe.create(title: 'Temaki', recipe_type: recipe_type,
                          cuisine: cuisine, difficulty: 'Médio',
                          cook_time: 50, user: user,
                          ingredients: 'Alga, Salmão, Arroz',
                          method: 'Enrolar tudo em cima de uma tabua')

    other_recipe = Recipe.create(title: 'Frango Teryaki', recipe_type: recipe_type,
                          cuisine: cuisine, difficulty: 'Médio',
                          cook_time: 50, user: user,
                          ingredients: 'Frango',
                          method: 'Assar o Frango e colocar molho')

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
