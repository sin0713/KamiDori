class CreateRecipeComments < ActiveRecord::Migration[5.2]
  def change
    create_table :recipe_comments do |t|
      t.integer :user_id, null: false, default: ""
      t.integer :recipe_id, null: false, default: ""
      t.string :comment, null: false, default: ""
      

      t.timestamps
    end
  end
end
