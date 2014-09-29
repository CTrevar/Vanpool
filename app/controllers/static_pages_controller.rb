class StaticPagesController < ApplicationController
  def home
    @user = User.new
    
    if signed_in?
      @cliente=obtener_cliente
      @current_cliente=obtener_cliente
  	  render 'clientes/dashboard'
      if @user.admin?
        render 'administradors/dashboard'
      else
        render 'users/dashboard'
      end
    end
  end

  def help
  end

  def about
  end

  def contact
  end
  
end
