class EntidadeEmpregadora < ApplicationRecord
  self.table_name = "entidades_empregadoras"
  belongs_to :client, class_name: "Cliente"

  validates :name, :income, presence: true
  validates :income, numericality: { greater_than: 0 }
end
