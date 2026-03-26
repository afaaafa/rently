class AutomoveisController < ApplicationController
  def show
    @automovel = Automovel.find(params[:id])
  end
end
