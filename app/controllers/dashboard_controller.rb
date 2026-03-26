class DashboardController < ApplicationController
  include AgentAccess

  def index
    @pending_count    = Pedido.where(status: :pending).count
    @reviewing_count  = Pedido.where(status: :under_review, agent: Current.user).count
    @vehicles_count   = Automovel.count
    @available_count  = Automovel.available.count

    @recent_pedidos = Pedido.includes(:client)
                            .where(status: [ :pending, :under_review ])
                            .order(created_at: :desc)
                            .limit(10)
  end
end
