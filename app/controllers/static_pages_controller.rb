class StaticPagesController < ApplicationController
  def home
    @user = User.new
    
    if signed_in?
<<<<<<< HEAD
      @cliente=obtener_cliente
  	  render 'clientes/dashboard'
=======
      if @user.admin?
        render 'administradors/dashboard'
      else
        render 'users/dashboard'
      end
>>>>>>> jTables
    end
  end

  def help
  end

  def about
  end

  def contact
  end

  def obtener_cliente
      @cliente = Cliente.find(current_user.id)
    end
  
end
