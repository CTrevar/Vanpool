module PagosHelper

    def get_merchant
        merchant_id='muvdvkft3dzo57bfzv5g'
    end

    def get_private
        private_id='sk_aa543af9dc964f83b41418a26aa6104f'
    end

    def obtener_cuenta  
        @cliente=obtener_cliente(current_user)
        @openpay=OpenpayApi.new(get_merchant,get_private)
        @customers=@openpay.create(:customers)
        return cuenta=@customers.get(@cliente.openpay_id)
    end

    def obtener_cuenta_vanpool 
        @openpay=OpenpayApi.new(get_merchant,get_private)
        @customers=@openpay.create(:customers)
        return cuenta=@customers.get("a86oeiwoibd2zz3k6og6")
    end

    def obtener_tranferencias_promocion
      @openpay=OpenpayApi.new(get_merchant,get_private)
      @transfers=@openpay.create(:transfers)
      transferencias=@transfers.all(obtener_cuenta_vanpool["id"])
      suma=0.0
      transferencias.each do |trans|
        if trans["operation_type"]=="out"
          suma=suma+trans["amount"]
        end
      end
      return suma
    end

    def obtener_cargos
      @openpay=OpenpayApi.new(get_merchant,get_private)

      @customers=@openpay.create(:customers)
      customs=@customers.all
      @charges=@openpay.create(:charges)

      cargos=Array.new
      customs.each do |custom|
        if @charges.all(custom["id"])!=[]
        cargos=cargos+@charges.all(custom["id"])
        end
      end
     
      c=cargos.group_by{|item| item["operation_date"].to_date}
      return c.map {|k,v| [k, v.length]}
    end

    def obtener_cuenta_admin
      @openpay=OpenpayApi.new(get_merchant,get_private)
      @customers=@openpay.create(:customers)
      return cuenta=@customers.get(@cliente.openpay_id)
    end

	def recarga
        # @cuenta=obtener_cuenta
        
        # @charges=@openpay.create(:charges)
        # card_hash={
        #     "holder_name" => "Juan Perez Ramirez",
        #     "card_number" => "4111111111111111",
        #     "cvv2" => "110",
        #     "expiration_month" => "12",
        #     "expiration_year" => "20"
        # }
       # request_hash={
       #      "method" => "card",
       #      "card" => card_hash,
       #      "amount" => 100.00,
       #      "description" => "Cargo inicial a mi cuenta",
       #      "device_session_id" => session[:session_id]
       # }
       # response_hash=@charges.create(request_hash.to_hash, @cuenta["id"])
    	# redirect_to :controller => 'clientes', :action => 'dashboard'
  	end


    def compra (cantidad)
        @cuenta=obtener_cuenta
        @cliente=obtener_cliente(current_user)

        @transfers=@openpay.create(:transfers)
        request_hash={
            "customer_id" => obtener_cuenta_vanpool["id"], #openpay_id de cliente
            "amount" => cantidad,
            "description" => "Compra de viaje"
        }
        return @transfers.create(request_hash.to_hash, @cliente.openpay_id) #numero de referencia de pago
        ##generar qr y reserva cambia de status
        #redirect_to :controller => 'clientes', :action => 'dashboard'
    end

    def compra_api (cantidad, id)
        @cuenta=obtener_cuenta_api(id)
        @cliente=Cliente.find(id)
        @transfers=@openpay.create(:transfers)
        request_hash={
            "customer_id" => obtener_cuenta_vanpool["id"], #openpay_id de cliente
            "amount" => cantidad,
            "description" => "Compra de viaje"
        }
        return @transfers.create(request_hash.to_hash, @cliente.openpay_id) #numero de referencia de pago
    end

    

    def obtener_saldo
        return obtener_cuenta["balance"]
    end

    def valida_saldo_suficiente (cantidad)
        saldo = obtener_saldo
        return saldo>=cantidad
    end

    def obtener_cuenta_api(id)
        @cliente=Cliente.find(id)
        @openpay=OpenpayApi.new(get_merchant,get_private)
        @customers=@openpay.create(:customers)
        return cuenta=@customers.get(@cliente.openpay_id)
    end

    def valida_saldo_suficiente_api (cantidad, id)
        saldo = obtener_cuenta_api(id)["balance"]
        return saldo>=cantidad
    end


end