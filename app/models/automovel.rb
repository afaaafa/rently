class Automovel < ApplicationRecord
  self.table_name = "automoveis"
  has_many :contratos_aluguel, class_name: "ContratoAluguel", dependent: :restrict_with_error
  has_one_attached :image

  scope :available, -> {
    where.not(id: ContratoAluguel.where("end_date >= ?", Date.today).select(:automovel_id))
  }

  validates :matricula, :year, :brand, :model, :plate, presence: true
  validates :plate, :matricula, uniqueness: true
end
