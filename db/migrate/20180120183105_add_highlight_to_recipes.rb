class AddHighlightToRecipes < ActiveRecord::Migration[5.1]
  def change
    add_column :recipes, :highlight, :boolean
  end
end
