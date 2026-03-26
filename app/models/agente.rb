class Agente < User
  has_many :pedidos, foreign_key: :agent_id, dependent: :nullify
end

require_dependency "empresa"
require_dependency "banco"
