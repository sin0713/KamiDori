class CreateRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :recipes do |t|
      t.integer :taist_id, null: false, default: ""
      t.integer :roast, null: false, default: ""
      t.string :bean, null: false, default: ""
      t.string :tool, null: false, default: ""
      t.integer :extraction_time_minutes, null: false, default: ""
      t.integer :extraction_time_seconds, null: false, default: ""
      t.integer :pre_infusion_time, null: false, default: ""
      t.integer :temperature, null: false, default: ""
      t.integer :grind_size, null: false, default: ""
      t.integer :amount_of_beans, null: false, default: ""
      t.integer :amount_of_extraction, null: false, default: ""
      t.text :introduction, default: ""
      t.string :image_id, default: ""
      
      t.timestamps
    end
  end
end
