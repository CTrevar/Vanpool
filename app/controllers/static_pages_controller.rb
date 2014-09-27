class StaticPagesController < ApplicationController
  def home
    @user = User.new
    
    if signed_in?
      @current_cliente=obtener_cliente
  	  render 'clientes/dashboard'
    end
  end

  def help
  end

  def about
  end

  def contact
  end
  
end
