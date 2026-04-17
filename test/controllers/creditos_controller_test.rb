require "test_helper"

class CreditosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @banco = Banco.create!(
      name: "Banco Credito",
      bank_code: "998",
      email_address: "banco-creditos@example.com",
      password: "password"
    )

    @empresa = Empresa.create!(
      name: "Agente Credito",
      company_name: "Locadora Credito",
      cnpj: "99.999.999/0001-98",
      email_address: "empresa-creditos@example.com",
      password: "password"
    )

    @cliente = Cliente.create!(
      name: "Cliente Credito",
      rg: "33.333.333-3",
      cpf: "333.333.333-33",
      profession: "Analista",
      address: { line: "Rua Credito, 100" },
      email_address: "cliente-creditos@example.com",
      password: "password"
    )

    @automovel = Automovel.create!(
      matricula: "MAT-CRD",
      year: 2025,
      brand: "Honda",
      model: "HR-V",
      plate: "CRD1A23",
      daily_rate: 280.00
    )

    @pedido = Pedido.create!(
      client: @cliente,
      automovel: @automovel,
      agent: @empresa,
      request_date: Date.today,
      status: :approved
    )

    @contrato = ContratoAluguel.create!(
      pedido: @pedido,
      automovel: @automovel,
      start_date: Date.today,
      end_date: 30.days.from_now.to_date,
      total_value: 8_500.00,
      contract_type: :bank
    )
  end

  test "banco can list pending credit contracts" do
    sign_in_as @banco

    get creditos_path

    assert_response :success
    assert_select "h1", "Análise de crédito"
    assert_select "a", "Associar crédito"
  end

  test "banco can associate credit contract" do
    sign_in_as @banco

    get new_credito_path(contrato_aluguel_id: @contrato.id)
    assert_response :success

    assert_difference "ContratoCredito.count", 1 do
      post creditos_path, params: {
        contrato_credito: {
          contrato_aluguel_id: @contrato.id,
          credit_value: "8500.00",
          interest_rate: "0.0199",
          installments: "24"
        }
      }
    end

    assert_redirected_to creditos_path
    assert_equal @banco, ContratoCredito.last.banco
    assert_equal @contrato, ContratoCredito.last.contrato_aluguel
  end

  test "empresa cannot access credit analysis" do
    sign_in_as @empresa

    get creditos_path

    assert_redirected_to dashboard_path
  end
end
