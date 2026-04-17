require "test_helper"

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test "new" do
    get new_registration_path

    assert_response :success
  end

  test "create client account" do
    assert_difference "Cliente.count", 1 do
      post registration_path, params: {
        cliente: {
          name: "Maria Cliente",
          rg: "33.333.333-3",
          cpf: "333.333.333-33",
          address_text: "Rua Tres, 300",
          profession: "Analista",
          email_address: "maria@example.com",
          password: "password",
          password_confirmation: "password"
        }
      }
    end

    assert_redirected_to root_path
    assert cookies[:session_id]
    assert_equal "Rua Tres, 300", Cliente.find_by!(email_address: "maria@example.com").address["line"]
  end
end
