FactoryBot.define do
  factory :recipe do
    title 'Bolo'
    difficulty 'Fácil'
    cook_time 45
    ingredients 'Varios'
    add_attribute(:method) { 'Misturar tudo'}
    cuisine
    recipe_type
  end
end
