class StaticPagesController < ApplicationController
   def home
      @user = User.new
      @result = Viaje.all
      
      if !current_user.nil?
        if !obtener_cliente(current_user).nil?
          @cliente=obtener_cliente(current_user)
        else
          @cliente = Cliente.create(puntaje:0,nivel_id:1,user_id:current_user.id)
          @openpay=OpenpayApi.new('muvdvkft3dzo57bfzv5g','sk_aa543af9dc964f83b41418a26aa6104f')
          @customers=@openpay.create(:customers)
        request_hash={
          "external_id" => nil,
          "name" => @cliente.user.name,
          "last_name" => nil,
          "email" => @cliente.user.email,
          "requires_account" => true,
        }
        response_hash=@customers.create(request_hash.to_hash)
        @cliente.openpay_id=response_hash["id"]
        @cliente.save
      redirect_to :controller => 'clientes', :action => 'dashboard'
        end
      end
  

      #if !current_user.nil?
      #  @current_cliente=obtener_cliente(current_user)
      #  if @user.admin?
      #    render 'administradors/inicio'
      #  else
      #    render 'clientes/dashboard'
      #  end
      #end
  end

  def help
  end

  def about
  end

  def contact
  end
end
