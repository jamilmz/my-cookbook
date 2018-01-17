require 'rails_helper'

RSpec.describe User do
  it 'user has favorited?' do
    user = create(:user)
    recipe = create(:recipe, user: user)
    Favorite.create(recipe: recipe, user: user)

    fav = user.favorited? recipe

    expect(fav).to be true
  end

  it 'user hasnt favorited' do
    user = create(:user)
    another_user = create(:user, email: 'outro@email.com')
    recipe = create(:recipe, user: user)
    Favorite.create(recipe: recipe, user: another_user)

    fav = user.favorited? recipe

    expect(fav).not_to be true
  end

  it 'recipe is nil in validating favorite' do
    user = create(:user)
    recipe = create(:recipe, user: user)
    Favorite.create(recipe: recipe, user: user)

    fav = user.favorited? nil

    expect(fav).to be false
  end

  it 'user owns the recipe' do
    user = create(:user)
    recipe = create(:recipe, user: user)
    Favorite.create(recipe: recipe, user: user)

    fav = user.my_recipe? recipe

    expect(fav).to be true
  end

  it 'user does not own the recipe' do
    user = create(:user)
    another_user = create(:user, email: 'another@email.com')
    recipe = create(:recipe, user: another_user)
    Favorite.create(recipe: recipe, user: user)

    fav = user.my_recipe? recipe

    expect(fav).to be false
  end

  it 'recipe is nil in validating owner' do
    user = create(:user)
    recipe = create(:recipe, user: user)
    Favorite.create(recipe: recipe, user: user)

    fav = user.my_recipe? nil

    expect(fav).to be false
  end
end
