class FixAutomovelForeignKey < ActiveRecord::Migration[8.1]
  def change
    remove_foreign_key :contratos_aluguel, column: :automovel_id
    add_foreign_key :contratos_aluguel, :automoveis, column: :automovel_id
  end
end
