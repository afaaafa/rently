class ContratoCredito < ApplicationRecord
  self.table_name = "contratos_credito"

  belongs_to :banco, class_name: "Banco"
  belongs_to :contrato_aluguel

  validates :credit_value, :interest_rate, :installments, presence: true
  validates :credit_value, numericality: { greater_than: 0 }
  validates :interest_rate, numericality: { greater_than: 0 }
  validates :installments, numericality: { only_integer: true, greater_than: 0 }
end
