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
  a.daily_rate = 120.00
end
gol.update!(daily_rate: 120.00)

civic = Automovel.find_or_create_by!(plate: "DEF-5678") do |a|
  a.matricula = "MAT-002"
  a.year      = 2022
  a.brand     = "Honda"
  a.model     = "Civic"
  a.daily_rate = 220.00
end
civic.update!(daily_rate: 220.00)

hilux = Automovel.find_or_create_by!(plate: "GHI-9012") do |a|
  a.matricula = "MAT-003"
  a.year      = 2023
  a.brand     = "Toyota"
  a.model     = "Hilux"
  a.daily_rate = 400.00
end
hilux.update!(daily_rate: 400.00)

onix = Automovel.find_or_create_by!(plate: "JKL-3456") do |a|
  a.matricula = "MAT-004"
  a.year      = 2020
  a.brand     = "Chevrolet"
  a.model     = "Onix"
  a.daily_rate = 140.00
end
onix.update!(daily_rate: 140.00)

argo = Automovel.find_or_create_by!(plate: "MNO-7890") do |a|
  a.matricula = "MAT-005"
  a.year      = 2022
  a.brand     = "Fiat"
  a.model     = "Argo"
  a.daily_rate = 150.00
end
argo.update!(daily_rate: 150.00)

hb20 = Automovel.find_or_create_by!(plate: "PQR-2345") do |a|
  a.matricula = "MAT-006"
  a.year      = 2021
  a.brand     = "Hyundai"
  a.model     = "HB20"
  a.daily_rate = 145.00
end
hb20.update!(daily_rate: 145.00)

renegade = Automovel.find_or_create_by!(plate: "STU-6789") do |a|
  a.matricula = "MAT-007"
  a.year      = 2023
  a.brand     = "Jeep"
  a.model     = "Renegade"
  a.daily_rate = 260.00
end
renegade.update!(daily_rate: 260.00)

kicks = Automovel.find_or_create_by!(plate: "VWX-0123") do |a|
  a.matricula = "MAT-008"
  a.year      = 2022
  a.brand     = "Nissan"
  a.model     = "Kicks"
  a.daily_rate = 240.00
end
kicks.update!(daily_rate: 240.00)

kwid = Automovel.find_or_create_by!(plate: "YZA-4567") do |a|
  a.matricula = "MAT-009"
  a.year      = 2021
  a.brand     = "Renault"
  a.model     = "Kwid"
  a.daily_rate = 115.00
end
kwid.update!(daily_rate: 115.00)

corolla = Automovel.find_or_create_by!(plate: "BCD-8901") do |a|
  a.matricula = "MAT-010"
  a.year      = 2023
  a.brand     = "Toyota"
  a.model     = "Corolla"
  a.daily_rate = 280.00
end
corolla.update!(daily_rate: 280.00)

t_cross = Automovel.find_or_create_by!(plate: "EFG-2346") do |a|
  a.matricula = "MAT-011"
  a.year      = 2024
  a.brand     = "Volkswagen"
  a.model     = "T-Cross"
  a.daily_rate = 310.00
end
t_cross.update!(daily_rate: 310.00)

# ---------------------------------------------------------------------------
# Pedidos & Contratos
# ---------------------------------------------------------------------------

# 1. Pending — Ana waiting for review
pedido_pending = Pedido.find_or_create_by!(client: ana, request_date: Date.today) do |p|
  p.status = :pending
  p.automovel = civic
end
pedido_pending.update!(automovel: civic) unless pedido_pending.automovel

# 2. Under review — Bruno being evaluated by the empresa agent
pedido_review = Pedido.find_or_create_by!(client: bruno, request_date: 3.days.ago.to_date) do |p|
  p.status = :under_review
  p.agent  = empresa
  p.automovel = onix
end
pedido_review.update!(automovel: onix) unless pedido_review.automovel

# 3. Approved with contract (client ownership) — Ana, older pedido
pedido_approved = Pedido.find_or_create_by!(client: ana, request_date: 10.days.ago.to_date) do |p|
  p.status = :approved
  p.agent  = empresa
  p.automovel = gol
end
pedido_approved.update!(automovel: gol) unless pedido_approved.automovel

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
  p.automovel = hilux
end
pedido_bank.update!(automovel: hilux) unless pedido_bank.automovel

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
  p.automovel = civic
end
pedido_rejected.update!(automovel: civic) unless pedido_rejected.automovel

# 6. Cancelled — Carla cancelled before review
pedido_cancelled = Pedido.find_or_create_by!(client: carla, request_date: 2.days.ago.to_date) do |p|
  p.status = :cancelled
  p.automovel = onix
end
pedido_cancelled.update!(automovel: onix) unless pedido_cancelled.automovel

Pedido.where(automovel_id: nil).find_each do |pedido|
  fallback_automovel = pedido.contrato_aluguel&.automovel || Automovel.first
  pedido.update!(automovel: fallback_automovel) if fallback_automovel
end

puts "Done! Seeded:"
puts "  Users:    #{User.count} (#{Cliente.count} clients, #{Agente.count} agents)"
puts "  Vehicles: #{Automovel.count}"
puts "  Pedidos:  #{Pedido.count} (#{Pedido.group(:status).count})"
puts "  Contratos de aluguel: #{ContratoAluguel.count}"
puts "  Contratos de crédito: #{ContratoCredito.count}"
