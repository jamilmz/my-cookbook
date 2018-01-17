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

end
