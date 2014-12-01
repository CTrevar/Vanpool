module PromocionesHelper

    def valida_regalo(medallamuro)
        medalla=Medalla.find(medallamuro.medalla_id)
      if medalla.regalo!=[]
        return true
      end
        return false
    end

    def obtener_regalos(cliente)
        regalos=Array.new
        medallasmuro=Medallasmuro.where(:cliente_id=>cliente.id)
        medallasmuro.each do |medallamuro|
            if valida_regalo (medallamuro)
                regalos<<medallamuro
            end
        end     
      return regalos
    end

    #Validar si el cliente tiene medallas
    def valida_promocion(medallamuro)
        medalla=Medalla.find(medallamuro.medalla_id)
      if medalla.saldopromocion!=nil
        return true
      end
        return false
    end

    def asigna_saldo_promocion(medallamuro)
        begin
            medallamuro=Medallasmuro.find(id_medallamuro)
            medalla=Medalla.find(medallamuro.medalla_id)
            cliente=Cliente.find(medallamuro.cliente_id)
            transfiere_saldo_promocion(medalla.saldopromocion, cliente)
            #medalla=Medallasmuro.where(:cliente_id=>medallamuro.cliente_id, :cobrado=>false, :medalla_id=>medallamuro.medalla.id)
            medallamuro.cobrado=true
            medallamuro.save
            return true
        rescue Exception
            return false
        end
    end


	def obtener_promociones(cliente)
        promociones=Array.new
        medallasmuro=Medallasmuro.where(:cliente_id=>cliente.id)
        medallasmuro.each do |medallamuro|
            if valida_promocion (medallamuro)
                promociones<<medallamuro
            end
        end		
      return promociones
    end

    def transfiere_saldo_promocion (saldopromocion, cliente)
        #@cuenta=obtener_cuenta
        #@cliente=cliente
        @openpay=OpenpayApi.new(get_merchant,get_private)
        @transfers=@openpay.create(:transfers)
        request_hash={
            "customer_id" => cliente.openpay_id, #openpay_id de vanpool
            "amount" => saldopromocion.cantidad,
            "description" => saldopromocion.nombre
        }
        return @transfers.create(request_hash.to_hash, "ate1ywygq39yso3xz5yw" ) #numero de referencia de pago
        
    end

    def obtener_regalos_no_entregados
        regalos=Array.new
        medallasmuro=Medallasmuro.where(:cobrado=>false)
        medallasmuro.each do |medallamuro|
            if valida_regalo (medallamuro)
                regalos<<medallamuro
            end
        end     
      return regalos
    end

    def cobra_regalo(id)
        medallamuro=Medallasmuro.find(id)
        medallamuro.cobrado=true
        medallamuro.save
    end

end
