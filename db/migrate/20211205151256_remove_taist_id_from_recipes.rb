class RemoveTaistIdFromRecipes < ActiveRecord::Migration[5.2]
  def change
    remove_column :recipes, :taist_id, :integer
  end
end
