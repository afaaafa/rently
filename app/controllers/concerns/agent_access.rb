module AgentAccess
  extend ActiveSupport::Concern

  included do
    before_action :require_agent!
    helper_method :fleet_manager?
  end

  private

  def require_agent!
    unless Current.user.is_a?(Agente)
      redirect_to root_path, alert: "Acesso restrito a agentes da locadora."
    end
  end

  def require_fleet_manager!
    unless fleet_manager?
      redirect_to automoveis_path, alert: "Acesso restrito a agentes da locadora."
    end
  end

  def fleet_manager?
    Current.user.is_a?(Empresa)
  end
end
