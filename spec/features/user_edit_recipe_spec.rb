require 'rails_helper'

feature 'User update recipe' do
  scenario 'successfully' do
    # cria os dados necessarios
    user = User.create(email: 'jamil@gmail.com', password: '12345678',
                       name: 'Jamil')
    arabian_cuisine = Cuisine.create(name: 'Arabe')
    main_type = RecipeType.create(name: 'Prato Principal')
    recipe = Recipe.create(title: 'Bolodecenoura', recipe_type: main_type,
                           cuisine: arabian_cuisine, difficulty: 'Médio',
                           cook_time: 50, user: user,
                           ingredients: 'Farinha, açucar, cenoura',
                           method: 'Cozinhe a cenoura, corte em pedaços'\
                                   'pequenos, misture com o restante dos'\
                                   ' ingredientes')

    # simula a acao do usuario
    visit root_path

    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password

    within('div.actions') do
      click_on 'Entrar'
    end

    click_on recipe.title
    click_on 'Editar'

    fill_in 'Título', with: 'Bolo de cenoura'
    select arabian_cuisine.name, from: 'Cozinha'
    select main_type.name, from: 'Tipo da Receita'
    fill_in 'Dificuldade', with: 'Médio'
    fill_in 'Tempo de Preparo', with: '45'
    fill_in 'Ingredientes', with: 'Cenoura, farinha, ovo, oleo de soja e '\
                                  'chocolate'
    fill_in 'Como Preparar', with: 'Faça um bolo e uma cobertura de chocolate'

    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Bolo de cenoura')
    expect(page).to have_css('h3', text: 'Detalhes')
    expect(page).to have_css('p', text: main_type.name)
    expect(page).to have_css('p', text: arabian_cuisine.name)
    expect(page).to have_css('p', text: 'Médio')
    expect(page).to have_css('p', text: '45 minutos')
    expect(page).to have_css('p', text:  'Cenoura, farinha, ovo, oleo de soja '\
                                         'e chocolate')
    expect(page).to have_css('p', text: 'Faça um bolo e uma cobertura de '\
                                        'chocolate')
  end

  scenario 'and all fields must be filled' do
    # cria os dados necessarios, nesse caso nao vamos criar dados no banco
    user = User.create(email: 'jamil@gmail.com', password: '12345678',
                       name: 'Jamil')
    arabian_cuisine = Cuisine.create(name: 'Arabe')
    main_type = RecipeType.create(name: 'Prato Principal')
    recipe = Recipe.create(title: 'Bolodecenoura', recipe_type: main_type,
                           cuisine: arabian_cuisine, difficulty: 'Médio',
                           cook_time: 50, user: user,
                           ingredients: 'Farinha, açucar, cenoura',
                           method: 'Cozinhe a cenoura, corte em pedaços '\
                                   'pequenos, misture com o restante dos '\
                                   'ingredientes')

    # simula a acao do usuario
    visit root_path

    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password

    within('div.actions') do
      click_on 'Entrar'
    end

    click_on recipe.title
    click_on 'Editar'

    fill_in 'Título', with: ''
    fill_in 'Dificuldade', with: ''
    fill_in 'Tempo de Preparo', with: ''
    fill_in 'Ingredientes', with: ''
    fill_in 'Como Preparar', with: ''

    click_on 'Enviar'

    expect(page).to have_content('Você deve informar todos os dados da receita')
  end
end
