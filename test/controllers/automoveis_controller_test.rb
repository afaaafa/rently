require "test_helper"

class AutomoveisControllerTest < ActionDispatch::IntegrationTest
  setup do
    @banco = Banco.create!(
      name: "Banco Teste",
      bank_code: "999",
      email_address: "banco-frota@example.com",
      password: "password"
    )

    @empresa = Empresa.create!(
      name: "Agente Teste",
      company_name: "Locadora Teste",
      cnpj: "99.999.999/0001-99",
      email_address: "empresa-frota@example.com",
      password: "password"
    )

    @automovel = Automovel.create!(
      matricula: "MAT-999",
      year: 2026,
      brand: "Toyota",
      model: "Corolla",
      plate: "TST9A99",
      daily_rate: 200.00
    )
  end

  test "banco can list fleet but cannot open new vehicle form" do
    sign_in_as @banco

    get automoveis_path
    assert_response :success
    assert_select "a", { text: "Novo veículo", count: 0 }

    get new_automovel_path
    assert_redirected_to automoveis_path
  end

  test "banco cannot create update or destroy vehicles" do
    sign_in_as @banco

    assert_no_difference "Automovel.count" do
      post automoveis_path, params: {
        automovel: {
          matricula: "MAT-1000",
          year: 2026,
          brand: "Honda",
          model: "Civic",
          plate: "TST1B00",
          daily_rate: "220.00"
        }
      }
    end
    assert_redirected_to automoveis_path

    assert_no_changes -> { @automovel.reload.model } do
      patch automovel_path(@automovel), params: {
        automovel: {
          model: "Civic"
        }
      }
    end
    assert_redirected_to automoveis_path

    assert_no_difference "Automovel.count" do
      delete automovel_path(@automovel)
    end
    assert_redirected_to automoveis_path
  end

  test "empresa can manage fleet" do
    sign_in_as @empresa

    get new_automovel_path
    assert_response :success

    assert_difference "Automovel.count", 1 do
      post automoveis_path, params: {
        automovel: {
          matricula: "MAT-1001",
          year: 2026,
          brand: "Honda",
          model: "Civic",
          plate: "TST1B01",
          daily_rate: "220.00"
        }
      }
    end
  end
end
