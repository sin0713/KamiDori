class AddRecipeIdToTaists < ActiveRecord::Migration[5.2]
  def change
    add_column :taists, :recipe_id, :integer
  end
end
