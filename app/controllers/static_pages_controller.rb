class StaticPagesController < ApplicationController
   def home
      @user = User.new
      if signed_in?
        @current_cliente=obtener_cliente(current_user)
        if @user.admin?
          render 'administradors/dashboard'
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
