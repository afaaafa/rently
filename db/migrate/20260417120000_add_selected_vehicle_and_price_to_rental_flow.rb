class AddSelectedVehicleAndPriceToRentalFlow < ActiveRecord::Migration[8.1]
  def change
    add_column :automoveis, :daily_rate, :decimal, precision: 10, scale: 2, null: false, default: 0
    add_reference :pedidos, :automovel, null: true, foreign_key: true
  end
end
