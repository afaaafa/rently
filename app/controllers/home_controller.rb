class HomeController < ApplicationController
  allow_unauthenticated_access

  def index
    @automoveis = Automovel.available.order(:brand, :model)
  end
end
