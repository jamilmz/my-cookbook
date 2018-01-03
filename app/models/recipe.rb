class Recipe < ApplicationRecord
	belongs_to :cuisine
	belongs_to :recipe_type

	validates :title, presence: true
	validates :recipe_type_id, presence: true
	validates :cuisine_id, presence: true 
	validates :difficulty, presence: true
	validates :cook_time, presence: true
	validates :ingredients, presence: true
	validates :method, presence: true
end
