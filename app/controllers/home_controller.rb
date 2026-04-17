class HomeController < ApplicationController
  allow_unauthenticated_access

  def index
    redirect_to dashboard_path and return if authenticated? && Current.user.is_a?(Agente)
    @automoveis = Automovel.available.with_attached_image.order(:brand, :model)
  end

  def slides
  end
end
