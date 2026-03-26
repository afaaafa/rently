class CreatePedidos < ActiveRecord::Migration[8.1]
  def change
    create_table :pedidos do |t|
      t.string :status, null: false, default: "pending"
      t.date :request_date, null: false
      t.references :client, null: false, foreign_key: { to_table: :users }
      t.references :agent, null: true, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
