class CreateTaists < ActiveRecord::Migration[5.2]
  def change
    create_table :taists do |t|
      t.integer :sour, null: false
      t.integer :bitter, null: false
      t.integer :sweet, null: false
      t.integer :flavor, null: false
      t.integer :rich, null: false

      t.timestamps
    end
  end
end
