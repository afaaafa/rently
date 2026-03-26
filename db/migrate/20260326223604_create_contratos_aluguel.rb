class CreateContratosAluguel < ActiveRecord::Migration[8.1]
  def change
    create_table :contratos_aluguel do |t|
      t.date :start_date
      t.date :end_date
      t.decimal :total_value, precision: 10, scale: 2
      t.string :contract_type
      t.references :pedido, null: false, foreign_key: true
      t.references :automovel, null: false, foreign_key: true

      t.timestamps
    end
  end
end
