class ApplicationController < ActionController::Base
  protect_from_forgery

  include SessionsHelper
  include ClientesHelper
  include GamificationHelper
  include ViajesHelper
  include CheckinHelper

end
