class AddRecipeTypeReferencesToRecipe < ActiveRecord::Migration[5.1]
  def change
    add_column :recipes, :recipe_type_id, :integer
    add_index :recipes, :recipe_type_id
  end
end
