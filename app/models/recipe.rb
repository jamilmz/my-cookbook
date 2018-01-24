class Recipe < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :cuisine
  belongs_to :recipe_type

  has_many :favorites, dependent: :destroy

  has_attached_file :image, styles: { medium: '300x300', thumb: '100x100>' }
  validates_attachment_content_type :image, content_type: %r{/\Aimage\/.*\z/}
  validates :title, :difficulty, :cook_time,
            :ingredients, :method, presence: true
end
