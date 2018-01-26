require 'rails_helper'

feature 'user has favorites' do
  scenario 'user marks a recipe as favorite' do
    user = create(:user)
    other_user = create(:user, email: 'joao@email.com')
    cuisine = create(:cuisine)
    recipe_type = create(:recipe_type)
    recipe = create(:recipe, user: user, cuisine: cuisine,
                             recipe_type: recipe_type)
    other_recipe = create(:recipe, title: 'Sushi', cuisine: cuisine,
                                   recipe_type: recipe_type, user: other_user)

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password
    within('div.actions') do
      click_on 'Entrar'
    end
    click_on recipe.title
    click_on 'Favoritar'

    expect(page).to have_content('Receita favoritada com sucesso')
    expect(page).to have_content(recipe.title)
    expect(page).not_to have_content(other_recipe.title)
  end

  scenario 'and click on Minhas Receitas Favoritas and see your favorites' do
    user = create(:user)
    other_user = create(:user, email: 'joao@email.com')
    cuisine = create(:cuisine)
    recipe_type = create(:recipe_type)
    recipe = create(:recipe, user: user, cuisine: cuisine,
                             recipe_type: recipe_type)
    other_recipe = create(:recipe, title: 'Sushi', cuisine: cuisine,
                                   recipe_type: recipe_type, user: other_user)

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password
    within('div.actions') do
      click_on 'Entrar'
    end

    click_on other_recipe.title
    click_on 'Favoritar'
    click_on 'Minhas Receitas Favoritas'

    expect(page).to have_link(other_recipe.title)
    expect(page).not_to have_link(recipe.title)
  end

  scenario 'ans has multiples favorites' do
    user = create(:user)
    other_user = create(:user, email: 'joao@email.com')
    cuisine = create(:cuisine)
    recipe_type = create(:recipe_type)
    recipe = create(:recipe, user: user, cuisine: cuisine,
                             recipe_type: recipe_type)
    other_recipe = create(:recipe, title: 'Sushi', cuisine: cuisine,
                                   recipe_type: recipe_type, user: other_user)
    another_recipe = create(:recipe, title: 'Rolinho Primavera',
                                     cuisine: cuisine,
                                     recipe_type: recipe_type, user: other_user)

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password
    within('div.actions') do
      click_on 'Entrar'
    end

    click_on other_recipe.title
    click_on 'Favoritar'
    click_on 'Ínicio'
    click_on another_recipe.title
    click_on 'Favoritar'
    click_on 'Minhas Receitas Favoritas'

    expect(page).to have_link(other_recipe.title)
    expect(page).to have_link(another_recipe.title)
    expect(page).not_to have_link(recipe.title)
  end

  scenario 'remove favorite' do
    user = create(:user)
    other_user = create(:user, email: 'joao@email.com')
    cuisine = create(:cuisine)
    recipe_type = create(:recipe_type)
    recipe = create(:recipe, user: other_user, cuisine: cuisine,
                             recipe_type: recipe_type)

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password
    within('div.actions') do
      click_on 'Entrar'
    end
    click_on recipe.title
    click_on 'Favoritar'
    click_on 'Minhas Receitas Favoritas'
    click_on recipe.title
    click_on 'Remover Favorito'
    click_on 'Minhas Receitas Favoritas'

    expect(page).not_to have_content recipe.title
  end

  scenario 'user visits the page of favorite recipes and the
    owner of the recipe deleted it' do
    user = create(:user)
    another_user = create(:user, email: 'another@gmail.com')
    recipe = create(:recipe, user: another_user)
    Favorite.create(user: user, recipe: recipe)

    login_as(another_user)
    recipe.destroy
    logout(another_user)

    login_as(user)
    visit root_path

    click_on 'Minhas Receitas Favoritas'

    expect(page).not_to have_link recipe.title
  end

  scenario 'visitor cant see favorite links' do
    user = create(:user)
    recipe = create(:recipe, user: user)

    visit root_path

    click_on recipe.title

    expect(page).not_to have_link 'Favoritar'
    expect(page).not_to have_link 'Remover Favorito'
  end
end
