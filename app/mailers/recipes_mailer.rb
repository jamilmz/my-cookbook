class RecipesMailer < ActionMailer::Base
  default from: 'no-replay.cookbook@gmail.com'

  def share(name, email, message, recipe_id)
    @name = name
    @message = message
    @recipe = Recipe.find(recipe_id)
    mail(to: email, subject: 'Ei amigo, o que acha desta receita?')
  end
end
