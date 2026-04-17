class ContratoCredito < ApplicationRecord
  self.table_name = "contratos_credito"

  belongs_to :banco, class_name: "Banco"
  belongs_to :contrato_aluguel

  validates :credit_value, :interest_rate, :installments, presence: true
  validates :contrato_aluguel_id, uniqueness: true
  validates :credit_value, numericality: { greater_than: 0 }
  validates :interest_rate, numericality: { greater_than: 0 }
  validates :installments, numericality: { only_integer: true, greater_than: 0 }
  validate :contrato_aluguel_must_be_bank_financed

  private

  def contrato_aluguel_must_be_bank_financed
    return unless contrato_aluguel

    unless contrato_aluguel.bank?
      errors.add(:contrato_aluguel, "deve ser financiado por banco")
    end
  end
end
