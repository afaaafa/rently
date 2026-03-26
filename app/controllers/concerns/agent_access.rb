module AgentAccess
  extend ActiveSupport::Concern

  included do
    before_action :require_agent!
  end

  private

  def require_agent!
    unless Current.user.is_a?(Agente)
      redirect_to root_path, alert: "Acesso restrito a agentes da locadora."
    end
  end
end
