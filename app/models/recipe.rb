class Recipe < ApplicationRecord
	belongs_to :user, optional: true
	belongs_to :cuisine
	belongs_to :recipe_type

	has_many :favorites, dependent: :destroy


	validates :title, :difficulty, :cook_time, :ingredients, :method, presence: true

end
