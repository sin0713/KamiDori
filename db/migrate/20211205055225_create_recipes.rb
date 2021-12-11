class CreateRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :recipes do |t|
      t.integer :taist_id, null: false
      t.integer :roast, null: false
      t.string :bean, null: false, default: ""
      t.string :tool, null: false, default: ""
      t.integer :extraction_time_minutes, null: false
      t.integer :extraction_time_seconds, null: false
      t.integer :pre_infusion_time, null: false
      t.integer :temperature, null: false
      t.integer :grind_size, null: false
      t.integer :amount_of_beans, null: false
      t.integer :amount_of_extraction, null: false
      t.text :introduction, default: ""
      t.string :image_id, default: ""
      
      t.timestamps
    end
  end
end
