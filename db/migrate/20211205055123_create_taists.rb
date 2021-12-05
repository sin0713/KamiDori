class CreateTaists < ActiveRecord::Migration[5.2]
  def change
    create_table :taists do |t|
      t.integer :sour, null: false, default: ""
      t.integer :bitter, null: false, default: ""
      t.integer :sweet, null: false, default: ""
      t.integer :flavor, null: false, default: ""
      t.integer :rich, null: false, default: ""

      t.timestamps
    end
  end
end
