class CreditosController < ApplicationController
  include AgentAccess
  before_action :require_bank!

  def index
    @pending_contracts = pending_credit_contracts
    @creditos = Current.user.contratos_credito
                           .includes(contrato_aluguel: [ :automovel, { pedido: :client } ])
                           .order(created_at: :desc)
  end

  def new
    @contrato_aluguel = pending_credit_contracts.find(params[:contrato_aluguel_id])
    @contrato_credito = Current.user.contratos_credito.build(
      contrato_aluguel: @contrato_aluguel,
      credit_value: @contrato_aluguel.total_value
    )
  end

  def create
    @contrato_aluguel = pending_credit_contracts.find(credito_params[:contrato_aluguel_id])
    @contrato_credito = Current.user.contratos_credito.build(credito_params)
    @contrato_credito.contrato_aluguel = @contrato_aluguel

    if @contrato_credito.save
      redirect_to creditos_path, notice: "Contrato de crédito associado com sucesso."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def require_bank!
    unless Current.user.is_a?(Banco)
      redirect_to dashboard_path, alert: "Acesso restrito ao banco."
    end
  end

  def pending_credit_contracts
    ContratoAluguel
      .bank
      .left_outer_joins(:contrato_credito)
      .where(contratos_credito: { id: nil })
      .includes(:automovel, pedido: :client)
      .order(created_at: :desc)
  end

  def credito_params
    params.require(:contrato_credito).permit(:contrato_aluguel_id, :credit_value, :interest_rate, :installments)
  end
end
