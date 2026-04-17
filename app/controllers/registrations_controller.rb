class RegistrationsController < ApplicationController
  allow_unauthenticated_access only: %i[ new create ]

  def new
    @cliente = Cliente.new
  end

  def create
    permitted = registration_params
    @address_text = permitted.delete(:address_text)
    @cliente = Cliente.new(permitted)
    @cliente.address = { line: @address_text } if @address_text.present?

    if @cliente.save
      start_new_session_for @cliente
      redirect_to root_path, notice: "Conta criada com sucesso."
    else
      render :new, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotUnique
    @cliente ||= Cliente.new
    @cliente.errors.add(:email_address, "já está em uso")
    render :new, status: :unprocessable_entity
  end

  private

    def registration_params
      params.require(:cliente).permit(
        :name,
        :rg,
        :cpf,
        :profession,
        :email_address,
        :password,
        :password_confirmation,
        :address_text
      )
    end
end
