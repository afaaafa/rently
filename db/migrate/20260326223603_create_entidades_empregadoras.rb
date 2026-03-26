class CreateEntidadesEmpregadoras < ActiveRecord::Migration[8.1]
  def change
    create_table :entidades_empregadoras do |t|
      t.string :name
      t.decimal :income
      t.references :client, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
