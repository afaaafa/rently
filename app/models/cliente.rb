class Cliente < User
  has_many :entidades_empregadoras, class_name: "EntidadeEmpregadora", foreign_key: :client_id, dependent: :destroy
  has_many :pedidos, foreign_key: :client_id, dependent: :destroy

  validates :rg, :cpf, :name, presence: true
  validates :cpf, uniqueness: true
  validates :entidades_empregadoras, length: { maximum: 3 }
end
