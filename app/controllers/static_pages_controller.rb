class StaticPagesController < ApplicationController
   def home
      @user = User.new
      @result = Viaje.all
      if signed_in?
        @current_cliente=obtener_cliente(current_user)
        if @user.admin?
          render 'administradors/inicio'
        else
          render 'clientes/dashboard'
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
