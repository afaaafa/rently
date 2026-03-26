class AutomoveisController < ApplicationController
  include AgentAccess
  skip_before_action :require_agent!, only: [ :show ]
  allow_unauthenticated_access only: [ :show ]
  before_action :set_automovel, only: [ :show, :edit, :update, :destroy ]

  def index
    @automoveis = Automovel.all.order(:brand, :model).with_attached_image
  end

  def show
  end

  def new
    @automovel = Automovel.new
  end

  def create
    @automovel = Automovel.new(automovel_params)
    if @automovel.save
      redirect_to automovel_path(@automovel), notice: "Veículo cadastrado com sucesso."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @automovel.update(automovel_params)
      redirect_to automovel_path(@automovel), notice: "Veículo atualizado com sucesso."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @automovel.destroy
      redirect_to automoveis_path, notice: "Veículo removido com sucesso."
    else
      redirect_to automoveis_path, alert: @automovel.errors.full_messages.to_sentence
    end
  end

  private

  def set_automovel
    @automovel = Automovel.find(params[:id])
  end

  def automovel_params
    params.expect(automovel: [ :matricula, :year, :brand, :model, :plate, :image ])
  end
end
