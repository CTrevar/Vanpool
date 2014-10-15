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

	def recarga
        @cuenta=obtener_cuenta
        
        @charges=@openpay.create(:charges)
        card_hash={
            "holder_name" => "Juan Perez Ramirez",
            "card_number" => "4111111111111111",
            "cvv2" => "110",
            "expiration_month" => "12",
            "expiration_year" => "20"
        }
        request_hash={
            "method" => "card",
            "card" => card_hash,   
            "amount" => 100.00,
            "description" => "Cargo inicial a mi cuenta",
            "device_session_id" => session[:session_id]
        }
        response_hash=@charges.create(request_hash.to_hash, @cuenta["id"])
    	redirect_to :controller => 'clientes', :action => 'dashboard'
  	end


    def compra
        @cuenta=obtener_cuenta

        @transfers=@openpay.create(:transfers)
        request_hash={
            "customer_id" => "ate1ywygq39yso3xz5yw",
            "amount" => 30,
            "description" => "Compra de viaje"
        }
        response_hash=@transfers.create(request_hash.to_hash, @cuenta["id"])
        ##generar qr y reserva cambia de status
        redirect_to :controller => 'clientes', :action => 'dashboard'
    end


end