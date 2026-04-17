class Banco < Agente
  has_many :contratos_credito, class_name: "ContratoCredito", foreign_key: :banco_id, dependent: :nullify

  validates :name, :bank_code, presence: true
  validates :bank_code, uniqueness: true
end
