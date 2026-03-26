class Pedido < ApplicationRecord
  belongs_to :client, class_name: "Cliente"
  belongs_to :agent, class_name: "Agente", optional: true
  has_one :contrato_aluguel, dependent: :destroy

  enum :status, {
    pending:     "pending",
    under_review: "under_review",
    approved:    "approved",
    rejected:    "rejected",
    cancelled:   "cancelled"
  }

  validates :status, :request_date, presence: true

  def editable?
    pending?
  end

  def cancellable?
    pending? || under_review?
  end
end
