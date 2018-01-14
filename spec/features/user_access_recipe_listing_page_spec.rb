require 'rails_helper'

feature 'user sees latest recipes at home' do
  scenario 'the last 6' do
    user = User.create(email: 'jamil@gmail.com', password: '12345678', name: 'Jamil')
    cuisine = Cuisine.create(name: 'Japonesa')
    recipe_type = RecipeType.create(name: 'Prato Principal')

    first_recipe = Recipe.create(title: 'Temaki', cuisine: cuisine,
            recipe_type: recipe_type, user: user, difficulty: 'Fácil',
            cook_time: 50, ingredients: 'Salmão', method: 'Enrola tudo')

    second_recipe = Recipe.create(title: 'Sushi', cuisine: cuisine,
            recipe_type: recipe_type, user: user, difficulty: 'Média',
            cook_time: 50, ingredients: 'Arroz', method: 'Enrola tudo')

    third_recipe = Recipe.create(title: 'Rolinho primavera', cuisine: cuisine,
            recipe_type: recipe_type, user: user, difficulty: 'Média',
            cook_time: 50, ingredients: 'Arroz', method: 'Enrola tudo')

    fourth_recipe = Recipe.create(title: 'Sashimi', cuisine: cuisine,
            recipe_type: recipe_type, user: user, difficulty: 'Média',
            cook_time: 50, ingredients: 'Arroz', method: 'Enrola tudo')

    fifth_recipe = Recipe.create(title: 'Tofu', cuisine: cuisine,
            recipe_type: recipe_type, user: user, difficulty: 'Média',
            cook_time: 50, ingredients: 'Arroz', method: 'Enrola tudo')

    sixth_recipe = Recipe.create(title: 'Ramen', cuisine: cuisine,
            recipe_type: recipe_type, user: user, difficulty: 'Média',
            cook_time: 50, ingredients: 'Arroz', method: 'Enrola tudo')

    seventh_recipe = Recipe.create(title: 'Yakisoba', cuisine: cuisine,
            recipe_type: recipe_type, user: user, difficulty: 'Média',
            cook_time: 50, ingredients: 'Arroz', method: 'Enrola tudo')


    visit root_path

    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password

    within('div.actions') do
      click_on 'Entrar'
    end

    expect(page).to have_content(second_recipe.title)
    expect(page).to have_content(third_recipe.title)
    expect(page).to have_content(fourth_recipe.title)
    expect(page).to have_content(fifth_recipe.title)
    expect(page).to have_content(sixth_recipe.title)
    expect(page).to have_content(seventh_recipe.title)
    expect(page).not_to have_content(first_recipe.title)


  end

  scenario 'sees all recipes' do
    user = User.create(email: 'jamil@gmail.com', password: '12345678', name: 'Jamil')
    cuisine = Cuisine.create(name: 'Japonesa')
    recipe_type = RecipeType.create(name: 'Prato Principal')

    first_recipe = Recipe.create(title: 'Temaki', cuisine: cuisine,
            recipe_type: recipe_type, user: user, difficulty: 'Fácil',
            cook_time: 50, ingredients: 'Salmão', method: 'Enrola tudo')

    second_recipe = Recipe.create(title: 'Sushi', cuisine: cuisine,
            recipe_type: recipe_type, user: user, difficulty: 'Média',
            cook_time: 50, ingredients: 'Arroz', method: 'Enrola tudo')

    third_recipe = Recipe.create(title: 'Rolinho primavera', cuisine: cuisine,
            recipe_type: recipe_type, user: user, difficulty: 'Média',
            cook_time: 50, ingredients: 'Arroz', method: 'Enrola tudo')

    fourth_recipe = Recipe.create(title: 'Sashimi', cuisine: cuisine,
            recipe_type: recipe_type, user: user, difficulty: 'Média',
            cook_time: 50, ingredients: 'Arroz', method: 'Enrola tudo')

    fifth_recipe = Recipe.create(title: 'Tofu', cuisine: cuisine,
            recipe_type: recipe_type, user: user, difficulty: 'Média',
            cook_time: 50, ingredients: 'Arroz', method: 'Enrola tudo')

    sixth_recipe = Recipe.create(title: 'Ramen', cuisine: cuisine,
            recipe_type: recipe_type, user: user, difficulty: 'Média',
            cook_time: 50, ingredients: 'Arroz', method: 'Enrola tudo')

    seventh_recipe = Recipe.create(title: 'Yakisoba', cuisine: cuisine,
            recipe_type: recipe_type, user: user, difficulty: 'Média',
            cook_time: 50, ingredients: 'Arroz', method: 'Enrola tudo')


    visit root_path

    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password

    within('div.actions') do
      click_on 'Entrar'
    end

    click_on 'Visualizar todas receitas'
    
    expect(page).to have_content(first_recipe.title)
    expect(page).to have_content(second_recipe.title)
    expect(page).to have_content(third_recipe.title)
    expect(page).to have_content(fourth_recipe.title)
    expect(page).to have_content(fifth_recipe.title)
    expect(page).to have_content(sixth_recipe.title)
    expect(page).to have_content(seventh_recipe.title)
  end
end
