require 'rails_helper'

RSpec.describe RecipesMailer do
  describe 'share' do
    it 'Send email correctly with all parameters' do
      user = create(:user)
      recipe = create(:recipe, user: user)

      name = 'Mika'
      message = 'Olha esta receita'
      email = 'mika@gmail.com'

      mail = RecipesMailer.share(name, email, message, recipe.id)

      expect(mail.to).to include email
      expect(mail.subject).to eq 'Ei amigo, o que acha desta receita?'
      expect(mail.from).to include 'no-replay.cookbook@gmail.com'
      expect(mail.body).to include name
      expect(mail.body).to include message
      expect(mail.body).to include recipe_url(recipe)
    end
  end
end
