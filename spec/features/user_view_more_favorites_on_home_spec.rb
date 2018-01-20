require 'rails_helper'

feature 'user view more favorites recipes on home' do
  scenario 'successfully' do
    user = create(:user)
    other_user = create(:user, email: 'other@email.com')
    another_user = create(:user, email: 'another@email.com')

    recipe_type = create(:recipe_type, name: 'Prato Principal')
    cuisine = create(:cuisine, name: 'Japonesa')

    rec1 = create(:recipe, cuisine: cuisine, recipe_type: recipe_type, user:user)
    rec2 = create(:recipe, cuisine: cuisine, recipe_type: recipe_type, user:user,
                  title: 'Misoshiru')
    rec3 = create(:recipe, cuisine: cuisine, recipe_type: recipe_type, user:user,
                  title: 'Sashimi boat')
    rec4 = create(:recipe, cuisine: cuisine, recipe_type: recipe_type, user:user,
                  title: 'Temaki California')


    Favorite.create(user: user, recipe: rec2)
    Favorite.create(user: other_user, recipe: rec2)
    Favorite.create(user: another_user, recipe: rec2)

    Favorite.create(user: other_user, recipe: rec3)
    Favorite.create(user: another_user, recipe: rec3)

    Favorite.create(user: other_user, recipe: rec4)

    login_as(other_user)
    visit root_path

    expect(page).not_to have_css('div.favorites', text: rec1.title)
    expect(page).to have_css('div.favorites', text: rec2.title)
    expect(page).to have_css('div.favorites', text: rec3.title)
    expect(page).to have_css('div.favorites', text: rec4.title)


  end
end
