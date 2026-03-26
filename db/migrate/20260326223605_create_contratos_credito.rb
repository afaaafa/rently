class CreateContratosCredito < ActiveRecord::Migration[8.1]
  def change
    create_table :contratos_credito do |t|
      t.decimal :credit_value, precision: 10, scale: 2
      t.decimal :interest_rate, precision: 5, scale: 4
      t.integer :installments
      t.references :banco, null: false, foreign_key: { to_table: :users }
      t.references :contrato_aluguel, null: false, foreign_key: { to_table: :contratos_aluguel }

      t.timestamps
    end
  end
end
