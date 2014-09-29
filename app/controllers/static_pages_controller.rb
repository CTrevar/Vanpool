class StaticPagesController < ApplicationController
  def home
    @user = User.new
    
    if signed_in?
<<<<<<< HEAD
# <<<<<<< HEAD
# <<<<<<< HEAD
      @cliente=obtener_cliente
#=======
      @current_cliente=obtener_cliente
#>>>>>>> bbe988770409e80f7e6c8acf72c8150a9ac74846
  	  render 'clientes/dashboard'
#=======
=======
      @current_cliente=obtener_cliente(current_user)
>>>>>>> 466b84c7eee686c1eff3d96cc9e8c68d2816b3c2
      if @user.admin?
        render 'administradors/dashboard'
      else
        render 'clientes/dashboard'
      end
<<<<<<< HEAD
#>>>>>>> jTables
=======
>>>>>>> 466b84c7eee686c1eff3d96cc9e8c68d2816b3c2
    end
  end

  def help
  end

  def about
  end

  def contact
  end
  
end
