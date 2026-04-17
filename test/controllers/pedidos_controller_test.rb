require "test_helper"

class PedidosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @empresa = Empresa.create!(
      name: "Agente Pedido",
      company_name: "Rently Teste",
      cnpj: "88.888.888/0001-88",
      email_address: "empresa-pedidos@example.com",
      password: "password"
    )

    @banco = Banco.create!(
      name: "Banco Pedido",
      bank_code: "997",
      email_address: "banco-pedidos@example.com",
      password: "password"
    )

    @cliente = Cliente.create!(
      name: "Cliente Pedido",
      rg: "44.444.444-4",
      cpf: "444.444.444-44",
      profession: "Arquiteta",
      address: { line: "Rua Pedido, 200" },
      email_address: "cliente-pedidos@example.com",
      password: "password"
    )

    @automovel = Automovel.create!(
      matricula: "MAT-PED",
      year: 2024,
      brand: "Toyota",
      model: "Corolla",
      plate: "PED1A23",
      daily_rate: 160.00
    )

    @pedido = Pedido.create!(
      client: @cliente,
      automovel: @automovel,
      request_date: Date.today,
      status: :pending
    )
  end

  test "cliente can create rental request from selected vehicle" do
    sign_in_as @cliente

    get new_pedido_path(automovel_id: @automovel.id)
    assert_response :success
    assert_select "h1", "Toyota Corolla"

    assert_difference "Pedido.count", 1 do
      post pedidos_path(automovel_id: @automovel.id)
    end

    assert_redirected_to pedido_path(Pedido.last)
    assert_equal @cliente, Pedido.last.client
    assert_equal @automovel, Pedido.last.automovel
  end

  test "empresa can list and select pedidos for review" do
    sign_in_as @empresa

    get pedidos_path
    assert_response :success
    assert_select "h1", "Pedidos dos clientes"
    assert_select "a", "Abrir análise"

    patch start_review_pedido_path(@pedido)
    assert_redirected_to pedido_path(@pedido)
    assert_equal "under_review", @pedido.reload.status
    assert_equal @empresa, @pedido.agent
  end

  test "empresa can approve pedido and execute contract" do
    sign_in_as @empresa

    assert_difference "ContratoAluguel.count", 1 do
      patch approve_pedido_path(@pedido), params: {
        contrato_aluguel: {
          start_date: Date.today,
          end_date: 30.days.from_now.to_date,
          contract_type: "bank"
        }
      }
    end

    assert_redirected_to pedido_path(@pedido)
    assert_equal "approved", @pedido.reload.status
    assert_equal @empresa, @pedido.agent
    assert_equal "bank", @pedido.contrato_aluguel.contract_type
    assert_equal @automovel, @pedido.contrato_aluguel.automovel
    assert_equal 4_800.00, @pedido.contrato_aluguel.total_value
  end

  test "empresa can reject pedido" do
    sign_in_as @empresa

    patch reject_pedido_path(@pedido)

    assert_redirected_to pedido_path(@pedido)
    assert_equal "rejected", @pedido.reload.status
    assert_equal @empresa, @pedido.agent
  end

  test "banco cannot access rental pedido analysis" do
    sign_in_as @banco

    get pedidos_path

    assert_redirected_to automoveis_path
  end
end
