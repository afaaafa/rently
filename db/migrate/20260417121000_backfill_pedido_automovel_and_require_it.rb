class BackfillPedidoAutomovelAndRequireIt < ActiveRecord::Migration[8.1]
  def up
    execute <<~SQL.squish
      UPDATE pedidos
      SET automovel_id = contratos_aluguel.automovel_id
      FROM contratos_aluguel
      WHERE pedidos.id = contratos_aluguel.pedido_id
        AND pedidos.automovel_id IS NULL
    SQL

    fallback_automovel_id = select_value("SELECT id FROM automoveis ORDER BY id LIMIT 1")

    if fallback_automovel_id
      execute <<~SQL.squish
        UPDATE pedidos
        SET automovel_id = #{fallback_automovel_id}
        WHERE automovel_id IS NULL
      SQL
    end

    change_column_null :pedidos, :automovel_id, false
  end

  def down
    change_column_null :pedidos, :automovel_id, true
  end
end
