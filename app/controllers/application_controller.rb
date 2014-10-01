class ApplicationController < ActionController::Base
  protect_from_forgery

  include SessionsHelper
  include ClientesHelper
  include GamificationHelper
  include ViajesHelper
  include CheckinHelper
  include NivelsHelper
  include MedallasHelper
  include ReservacionsHelper
  include VanHelper
  include RetroaspectosHelper
  include DescuentosHelper

end
