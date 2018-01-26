require 'rails_helper'

feature 'User manage only your recipes' do
  scenario 'successfully' do
    user = create(:user)
    other_user = create(:user, email: 'other@gmail.com')
    cuisine = create(:cuisine)
    recipe_type = create(:recipe_type)
    recipe = create(:recipe, user: user, cuisine: cuisine,
                             recipe_type: recipe_type)
    other_recipe = create(:recipe, title: 'coxinha',
                                   user: other_user, cuisine: cuisine,
                                   recipe_type: recipe_type)
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password

    within('div.actions') do
      click_on 'Entrar'
    end

    click_on 'Minhas Receitas'

    expect(page).to have_css('h1', text: recipe.title)
    expect(page).to have_css('li', text: recipe.recipe_type.name)
    expect(page).to have_css('li', text: recipe.cuisine.name)
    expect(page).to have_css('li', text: recipe.difficulty)
    expect(page).to have_css('li', text: "#{recipe.cook_time} minutos")
    expect(page).not_to have_css('h1', text: other_recipe.title)
  end

  scenario 'User log in and can see edit button' do
    user = create(:user)
    cuisine = create(:cuisine)
    recipe_type = create(:recipe_type)
    recipe = create(:recipe, user: user, cuisine: cuisine,
                             recipe_type: recipe_type)
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password
    within('div.actions') do
      click_on 'Entrar'
    end

    click_on 'Minhas Receitas'
    click_on recipe.title

    expect(page).to have_link('Editar')
  end

  scenario 'User doesnt see edit button on anothers user recipe' do
    user = create(:user)
    other_user = create(:user, email: 'other@gmail.com')
    cuisine = create(:cuisine)
    recipe_type = create(:recipe_type)
    recipe = create(:recipe, user: user, cuisine: cuisine,
                             recipe_type: recipe_type)
    other_recipe = create(:recipe, title: 'coxinha',
                                   user: other_user, cuisine: cuisine,
                                   recipe_type: recipe_type)

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password
    within('div.actions') do
      click_on 'Entrar'
    end
    click_on other_recipe.title

    expect(page).to have_css('h1', text: other_recipe.title)
    expect(page).not_to have_css('h1', text: recipe.title)
    expect(page).not_to have_link('Editar')
  end

  scenario 'User accesses the edit route, and does not own the recipe' do
    user = User.create(email: 'jamil@gmail.com', password: '12345678',
                       name: 'Jamil')
    other_user = User.create(email: 'joao@email.com', password: '87654321',
                             name: 'Joao')
    cuisine = Cuisine.create(name: 'Japonesa')
    recipe_type = RecipeType.create(name: 'Prato Principal')
    recipe = Recipe.create(title: 'Temaki', cuisine: cuisine,
                           recipe_type: recipe_type, user: user,
                           difficulty: 'Fácil',
                           cook_time: 50, ingredients: 'Salmão',
                           method: 'Enrola tudo')
    other_recipe = Recipe.create(title: 'Sushi', cuisine: cuisine,
                                 recipe_type: recipe_type, user: other_user,
                                 difficulty: 'Média',
                                 cook_time: 50, ingredients: 'Arroz',
                                 method: 'Enrola tudo')

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password

    within('div.actions') do
      click_on 'Entrar'
    end

    click_on other_recipe.title
    visit edit_recipe_path(id: other_recipe.id)

    expect(page).to have_content(recipe.title)
    expect(page).not_to have_content('Detalhes')
  end
end
