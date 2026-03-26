class CreateAutomoveis < ActiveRecord::Migration[8.1]
  def change
    create_table :automoveis do |t|
      t.string :matricula
      t.integer :year
      t.string :brand
      t.string :model
      t.string :plate

      t.timestamps
    end
    add_index :automoveis, :plate, unique: true
  end
end
