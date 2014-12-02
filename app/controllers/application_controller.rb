class ApplicationController < ActionController::Base
  protect_from_forgery
  #protect_from_forgery with: :null_session, :if => Proc.new { |c| c.request.format == 'application/json' }
  respond_to :json, :html
  
  include ClientesHelper
  include GamificationHelper
  include ViajesHelper
  include CheckinHelper
  include NivelsHelper
  include MedallasHelper
  include ReservacionsHelper
  include VanHelper
  include RetroaspectosHelper
  #include DescuentosHelper
  include PagosHelper
  include RutasHelper
  include AdministradorsHelper
  include SugerenciasHelper
  include LidersHelper
  include PromocionesHelper

  def after_sign_in_path_for(resource)
  if current_user.has_role? :admin
    inicio_path
  else
    dashboard_path
  end
end

end
