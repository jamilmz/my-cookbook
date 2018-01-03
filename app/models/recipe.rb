class Recipe < ApplicationRecord
	belongs_to :cuisine

	validates :title, presence: true
	validates :recipe_type, presence: true
	validates :cuisine_id, presence: true 
	validates :difficulty, presence: true
	validates :cook_time, presence: true
	validates :ingredients, presence: true
	validates :method, presence: true
end
