class ContratoAluguel < ApplicationRecord
  self.table_name = "contratos_aluguel"

  belongs_to :pedido
  belongs_to :automovel
  has_one :contrato_credito, dependent: :destroy

  enum :contract_type, {
    client:  "client",
    company: "company",
    bank:    "bank"
  }

  validates :start_date, :end_date, :total_value, :contract_type, presence: true
  validates :total_value, numericality: { greater_than: 0 }
  validate :end_date_after_start_date

  private

  def end_date_after_start_date
    return unless start_date && end_date
    errors.add(:end_date, "must be after start date") if end_date <= start_date
  end
end
