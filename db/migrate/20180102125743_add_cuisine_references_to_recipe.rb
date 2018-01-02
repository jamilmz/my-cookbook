class AddCuisineReferencesToRecipe < ActiveRecord::Migration[5.1]
  def change
    add_column :recipes, :cuisine_id, :integer
    add_index :recipes, :cuisine_id
  end
end
