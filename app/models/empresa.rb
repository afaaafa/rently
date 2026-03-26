class Empresa < Agente
  validates :company_name, :cnpj, presence: true
  validates :cnpj, uniqueness: true
end
