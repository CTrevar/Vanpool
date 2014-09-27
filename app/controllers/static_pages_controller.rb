class StaticPagesController < ApplicationController
  def home
    @user = User.new
    
    if signed_in?
# <<<<<<< HEAD
# <<<<<<< HEAD
      @cliente=obtener_cliente
#=======
      @current_cliente=obtener_cliente
#>>>>>>> bbe988770409e80f7e6c8acf72c8150a9ac74846
  	  render 'clientes/dashboard'
#=======
      if @user.admin?
        render 'administradors/dashboard'
      else
        render 'users/dashboard'
      end
#>>>>>>> jTables
    end
  end

  def help
  end

  def about
  end

  def contact
  end

  def obtener_cliente
      @cliente = Cliente.find_by_user_id(current_user.id)
  end
  
end
