# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

puts "Seeding..."

# ---------------------------------------------------------------------------
# Agents
# ---------------------------------------------------------------------------

banco = Banco.find_or_create_by!(email_address: "banco@bradesco.com.br") do |u|
  u.name          = "Bradesco"
  u.bank_code     = "237"
  u.password      = "password123"
  u.profession    = "Instituição Financeira"
  u.address       = { street: "Cidade de Deus", city: "Osasco", state: "SP", zip: "06029-900" }
end

empresa = Empresa.find_or_create_by!(email_address: "agente@rentlylocadora.com.br") do |u|
  u.name         = "Carlos Mendes"
  u.company_name = "Rently Locadora Ltda"
  u.cnpj         = "12.345.678/0001-99"
  u.password     = "password123"
  u.profession   = "Agente de Locação"
  u.address      = { street: "Av. Paulista, 1000", city: "São Paulo", state: "SP", zip: "01310-100" }
end

# ---------------------------------------------------------------------------
# Clients
# ---------------------------------------------------------------------------

ana = Cliente.find_or_create_by!(email_address: "ana@email.com") do |u|
  u.name       = "Ana Paula Souza"
  u.cpf        = "111.222.333-44"
  u.rg         = "12.345.678-9"
  u.profession = "Engenheira"
  u.password   = "password123"
  u.address    = { street: "Rua das Flores, 42", city: "São Paulo", state: "SP", zip: "01001-000" }
end

ana.entidades_empregadoras.find_or_create_by!(name: "Tech Corp S.A.") do |e|
  e.income = 12_000.00
end

ana.entidades_empregadoras.find_or_create_by!(name: "Freelance") do |e|
  e.income = 3_500.00
end

bruno = Cliente.find_or_create_by!(email_address: "bruno@email.com") do |u|
  u.name       = "Bruno Lima"
  u.cpf        = "555.666.777-88"
  u.rg         = "98.765.432-1"
  u.profession = "Professor"
  u.password   = "password123"
  u.address    = { street: "Av. Brasil, 200", city: "Campinas", state: "SP", zip: "13010-000" }
end

bruno.entidades_empregadoras.find_or_create_by!(name: "Universidade Estadual") do |e|
  e.income = 8_000.00
end

carla = Cliente.find_or_create_by!(email_address: "carla@email.com") do |u|
  u.name       = "Carla Ferreira"
  u.cpf        = "999.888.777-66"
  u.rg         = "55.444.333-2"
  u.profession = "Médica"
  u.password   = "password123"
  u.address    = { street: "Rua XV de Novembro, 300", city: "Curitiba", state: "PR", zip: "80020-310" }
end

carla.entidades_empregadoras.find_or_create_by!(name: "Hospital São Lucas") do |e|
  e.income = 22_000.00
end

# ---------------------------------------------------------------------------
# Vehicles
# ---------------------------------------------------------------------------

gol = Automovel.find_or_create_by!(plate: "ABC-1234") do |a|
  a.matricula = "MAT-001"
  a.year      = 2021
  a.brand     = "Volkswagen"
  a.model     = "Gol"
end

civic = Automovel.find_or_create_by!(plate: "DEF-5678") do |a|
  a.matricula = "MAT-002"
  a.year      = 2022
  a.brand     = "Honda"
  a.model     = "Civic"
end

hilux = Automovel.find_or_create_by!(plate: "GHI-9012") do |a|
  a.matricula = "MAT-003"
  a.year      = 2023
  a.brand     = "Toyota"
  a.model     = "Hilux"
end

onix = Automovel.find_or_create_by!(plate: "JKL-3456") do |a|
  a.matricula = "MAT-004"
  a.year      = 2020
  a.brand     = "Chevrolet"
  a.model     = "Onix"
end

# ---------------------------------------------------------------------------
# Pedidos & Contratos
# ---------------------------------------------------------------------------

# 1. Pending — Ana waiting for review
pedido_pending = Pedido.find_or_create_by!(client: ana, request_date: Date.today) do |p|
  p.status = :pending
end

# 2. Under review — Bruno being evaluated by the empresa agent
pedido_review = Pedido.find_or_create_by!(client: bruno, request_date: 3.days.ago.to_date) do |p|
  p.status = :under_review
  p.agent  = empresa
end

# 3. Approved with contract (client ownership) — Ana, older pedido
pedido_approved = Pedido.find_or_create_by!(client: ana, request_date: 10.days.ago.to_date) do |p|
  p.status = :approved
  p.agent  = empresa
end

ContratoAluguel.find_or_create_by!(pedido: pedido_approved) do |c|
  c.automovel     = gol
  c.start_date    = 5.days.ago.to_date
  c.end_date      = 25.days.from_now.to_date
  c.total_value   = 3_000.00
  c.contract_type = :client
end

# 4. Approved with bank-financed contract — Carla
pedido_bank = Pedido.find_or_create_by!(client: carla, request_date: 15.days.ago.to_date) do |p|
  p.status = :approved
  p.agent  = empresa
end

contrato_bank = ContratoAluguel.find_or_create_by!(pedido: pedido_bank) do |c|
  c.automovel     = hilux
  c.start_date    = 7.days.ago.to_date
  c.end_date      = 23.days.from_now.to_date
  c.total_value   = 12_000.00
  c.contract_type = :bank
end

ContratoCredito.find_or_create_by!(contrato_aluguel: contrato_bank) do |cc|
  cc.banco        = banco
  cc.credit_value = 12_000.00
  cc.interest_rate = 0.0199
  cc.installments = 24
end

# 5. Rejected — Bruno, another pedido
pedido_rejected = Pedido.find_or_create_by!(client: bruno, request_date: 20.days.ago.to_date) do |p|
  p.status = :rejected
  p.agent  = empresa
end

# 6. Cancelled — Carla cancelled before review
pedido_cancelled = Pedido.find_or_create_by!(client: carla, request_date: 2.days.ago.to_date) do |p|
  p.status = :cancelled
end

puts "Done! Seeded:"
puts "  Users:    #{User.count} (#{Cliente.count} clients, #{Agente.count} agents)"
puts "  Vehicles: #{Automovel.count}"
puts "  Pedidos:  #{Pedido.count} (#{Pedido.group(:status).count})"
puts "  Contratos de aluguel: #{ContratoAluguel.count}"
puts "  Contratos de crédito: #{ContratoCredito.count}"
