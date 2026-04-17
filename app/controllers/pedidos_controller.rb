class PedidosController < ApplicationController
  include AgentAccess
  skip_before_action :require_agent!, only: %i[ index show new create ]
  before_action :require_client!, only: %i[ new create ]
  before_action :require_fleet_manager!, only: %i[ start_review approve reject ]
  before_action :set_automovel, only: %i[ new create ]
  before_action :set_pedido, only: %i[ show start_review approve reject ]
  before_action :ensure_pedido_access!, only: %i[ show start_review approve reject ]

  def index
    if Current.user.is_a?(Cliente)
      @pedidos = Current.user.pedidos.includes(:automovel, :contrato_aluguel).order(created_at: :desc)
      render :client_index
      return
    end

    unless fleet_manager?
      require_fleet_manager!
      return
    end

    @pending_pedidos = Pedido.includes(:client, :automovel)
                             .pending
                             .order(created_at: :asc)

    @reviewing_pedidos = Pedido.includes(:client, :automovel)
                               .where(status: :under_review, agent: Current.user)
                               .order(updated_at: :desc)

    @finished_pedidos = Pedido.includes(:client, :automovel, :contrato_aluguel)
                              .where(agent: Current.user, status: %i[ approved rejected ])
                              .order(updated_at: :desc)
                              .limit(10)
  end

  def new
    @pedido = Current.user.pedidos.build(automovel: @automovel, request_date: Date.today)
  end

  def create
    @pedido = Current.user.pedidos.build(automovel: @automovel, request_date: Date.today)

    if @pedido.save
      redirect_to pedido_path(@pedido), notice: "Pedido de aluguel criado com sucesso."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    if Current.user.is_a?(Cliente)
      render :client_show
      return
    end

    unless fleet_manager?
      require_fleet_manager!
      return
    end
    @contrato_aluguel = @pedido.contrato_aluguel || @pedido.build_contrato_aluguel(default_contract_attributes)
  end

  def start_review
    if @pedido.pending?
      @pedido.update!(status: :under_review, agent: Current.user)
      redirect_to pedido_path(@pedido), notice: "Pedido selecionado para análise."
    else
      redirect_to pedido_path(@pedido), alert: "Este pedido não pode ser selecionado para análise."
    end
  end

  def approve
    @contrato_aluguel = @pedido.contrato_aluguel || @pedido.build_contrato_aluguel
    @contrato_aluguel.assign_attributes(contrato_params.merge(
      automovel: @pedido.automovel,
      total_value: contract_total_value
    ))

    Pedido.transaction do
      @contrato_aluguel.save!
      @pedido.update!(status: :approved, agent: Current.user)
    end

    redirect_to pedido_path(@pedido), notice: "Pedido aprovado e contrato executado."
  rescue ActiveRecord::RecordInvalid
    render :show, status: :unprocessable_entity
  end

  def reject
    if @pedido.pending? || @pedido.under_review?
      @pedido.update!(status: :rejected, agent: Current.user)
      redirect_to pedido_path(@pedido), notice: "Pedido recusado."
    else
      redirect_to pedido_path(@pedido), alert: "Este pedido não pode ser recusado."
    end
  end

  private

  def set_pedido
    @pedido = Pedido.includes(:client, :automovel, :contrato_aluguel).find(params[:id])
  end

  def set_automovel
    @automovel = Automovel.available.find(params[:automovel_id])
  end

  def ensure_pedido_access!
    if Current.user.is_a?(Cliente)
      return if @pedido.client == Current.user

      redirect_to pedidos_path, alert: "Você não pode acessar este pedido."
      return
    end

    return if @pedido.pending?
    return if @pedido.agent == Current.user

    redirect_to pedidos_path, alert: "Este pedido está em análise por outro agente."
  end

  def default_contract_attributes
    {
      start_date: Date.today,
      end_date: 30.days.from_now.to_date,
      total_value: @pedido.automovel.daily_rate * 30,
      contract_type: :client
    }
  end

  def require_client!
    unless Current.user.is_a?(Cliente)
      redirect_to root_path, alert: "Apenas clientes podem criar pedidos de aluguel."
    end
  end

  def contract_total_value
    start_date = Date.parse(contrato_params[:start_date])
    end_date = Date.parse(contrato_params[:end_date])
    days = (end_date - start_date).to_i

    @pedido.automovel.daily_rate * days
  rescue Date::Error, TypeError
    nil
  end

  def contrato_params
    params.require(:contrato_aluguel).permit(:start_date, :end_date, :contract_type)
  end
end
