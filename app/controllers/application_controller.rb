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

end
