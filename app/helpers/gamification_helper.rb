module GamificationHelper

	#cambio de nivel
	def cambio_nivel(cliente)
		niveles=Nivel.find_all_by_estatus(true)
		niveles.each do |nivel|
    		if(cliente.puntaje>nivel.rangomaximo && valida_ultimo_nivel(cliente)==false)then
      			cliente.nivel_id=nivel.id+1
    		end
    	end
    	cliente.save
        asigna_medalla_nivel(cliente)
	end

	#Dar medalla tipo viaje
    def asigna_medalla_viaje(cliente)
    	medallas=Medalla.find_all_by_tipomedalla_id_and_estatus(1,true)
    	medallas.each do |medalla|
    		if(cliente.reservacions.find_all_by_estadotipo_id(3).count==medalla.estado) then
      			medallamuro = Medallasmuro.create(cliente_id:cliente.id,medalla_id:medalla.id)
      			medallamuro.save
      			aumenta_puntos(cliente,medalla.puntos)
                if valida_promocion(medallamuro)
                    asigna_saldo_promocion(medallamuro)
                end
    		end
    	end
    end

     #Dar medalla tipo lleno total
    def asigna_medalla_llenototal(cliente)
        medallas=Medalla.find_all_by_tipomedalla_id_and_estatus(4,true)
        reservaciones=Reservacion.find_all_by_cliente_id_and_estadotipo_id(cliente.id,[2,3])
        llenostotales=0

        reservaciones.each do |reservacion|
            if(valida_van_llena(reservacion.viaje.ruta.van, reservacion.viaje))then
                llenostotales=llenostotales+1
            end
        end

        medallas.each do |medalla| 
            if(llenostotales==medalla.estado) then
                medallamuro = Medallasmuro.create(cliente_id:cliente.id,medalla_id:medalla.id)
                medallamuro.save
                aumenta_puntos(cliente,medalla.puntos)
                if valida_promocion(medallamuro)
                    asigna_saldo_promocion(medallamuro)
                end
            end
        end
    end

    def envia_retro
        #retro.save
        #asigna_medalla_retro(cliente)
    end

    #Dar medalla tipo retro
    ##no esta probado
    def asigna_medalla_retro(cliente)
        medallas=Medalla.find_all_by_tipomedalla_id_and_estatus(3,true)
        reservas=Reservacion.find_all_by_cliente_id_and_estadotipo_id(cliente.id,[2,3])
        cuenta=0
        reservas.each do |reserva|
            if(reserva.retroalimentacions.count==1) then
                cuenta=cuenta+1
            end
        end

        medallas.each do |medalla|
            if(cuenta==medalla.estado) then
                medallamuro = Medallasmuro.create(cliente_id:cliente.id,medalla_id:medalla.id)
                medallamuro.save
                aumenta_puntos(cliente,medalla.puntos)
                if valida_promocion(medallamuro)
                    asigna_saldo_promocion(medallamuro)
                end
            end
        end
    end

    def envia_share
        #share.save
        #asigna_medalla_retro(cliente)
    end

    #Dar medalla tipo social
    ##no esta probado
    def asigna_medalla_social(cliente)
        medallas=Medalla.find_all_by_tipomedalla_id_and_estatus(2,true)
        shares=Share.find_all_by_cliente_id(cliente.id) ##cambiarlo por id facebook

        medallas.each do |medalla|
            if(shares.count==medalla.estado) then
                medallamuro = Medallasmuro.create(cliente_id:cliente.id,medalla_id:medalla.id)
                medallamuro.save
                aumenta_puntos(cliente,medalla.puntos)
                if valida_promocion(medallamuro)
                    asigna_saldo_promocion(medallamuro)
                end
            end
        end
    end

    #Dar medalla tipo cumpleaños
    ##no esta probado
    ##como se valida que no haya cambiado la fecha solo para tener la promo
    def asigna_medalla_bday(cliente)
        #medalla=Medalla.find_by_tipomedalla_id_and_estatus(5,true)
        #if(cliente.fechanacimiento==date.now) then
            #medallamuro = Medallasmuro.create(cliente_id:cliente.id,medalla_id:medalla.id)
            #medallamuro.save
            #aumenta_puntos(cliente,medalla.puntos)
        #end
    end

    #Metodo con facebook
    def obtener_amigos(cliente)
        amigos=["1","2","3"]
        return amigos
    end

    def viaja_con_amigos(cliente,reservacion)
        viaje=reservacion.viaje
        pasajeros=viaje.reservacions
        amigos=obtener_amigos
        amigosenviaje=0

        amigos.each do |amigo|
            pasajeros.each do |pasajero|
                if(pasajero==amigo)then
                    amigosenviaje=amigosenviaje+1
                end
            end
        end
        return amigosenviaje
    end

    #Dar medalla tipo viaja con amigos
    ##no esta probado
    def asigna_medalla_amigos(cliente, reservacion)
        medallas=Medalla.find_all_by_tipomedalla_id_and_estatus(7,true)

        medallas.each do |medalla| 
            if(viaja_con_amigos(cliente,reservacion)>=medalla.estado) then
                medallamuro = Medallasmuro.create(cliente_id:cliente.id,medalla_id:medalla.id)
                medallamuro.save
                aumenta_puntos(cliente,medalla.puntos)
                if valida_promocion(medallamuro)
                    asigna_saldo_promocion(medallamuro)
                end
            end
        end
    end

    #Dar medalla tipo anfitrion
    ##no esta probado
    ##en donde se guarda la cantidad de reservas???
    def asigna_medalla_anfitrion(cliente, reservacion)
        medallas=Medalla.find_all_by_tipomedalla_id_and_estatus(8,true)

        medallas.each do |medalla| 
            #if(reservacion.cantidad==medalla.estado) then
                medallamuro = Medallasmuro.create(cliente_id:cliente.id,medalla_id:medalla.id)
                medallamuro.save
                aumenta_puntos(cliente,medalla.puntos)
                if valida_promocion(medallamuro)
                    asigna_saldo_promocion(medallamuro)
                end
            #end
        end
    end

    #Dar medalla tipo anfitrion
    ##no esta probado
    def asigna_medalla_nivel(cliente)
        medallas=Medalla.find_all_by_tipomedalla_id_and_estatus(9,true)

        medallas.each do |medalla| 
            if(cliente.nivel_id==medalla.estado) then
                medallamuro = Medallasmuro.create(cliente_id:cliente.id,medalla_id:medalla.id)
                medallamuro.save
                aumenta_puntos(cliente,medalla.puntos)
                if valida_promocion(medallamuro)
                    asigna_saldo_promocion(medallamuro)
                end
            end
        end
    end

    #asigna lider de parada
    def asigna_lider(cliente, ruta)
        recordcliente=Cliente.find(cliente.id).reservacions.joins(:viaje).where('viajes.ruta_id'=>ruta.id,'reservacions.estadotipo_id'=>3).count
        recordactual= Lider.where(:ruta_id=>ruta.id, :estatus=>true).maximum(:record)
           
        if Lider.where(:ruta_id=>ruta.id).exists? && recordactual != nil
                if recordcliente > recordactual
                    lider= Lider.create(cliente_id: cliente.id, ruta_id: ruta.id, record: recordcliente, estatus: true)
                    lideresanteriores=Lider.where(:ruta_id=>ruta.id, :estatus=>true, :record=>recordactual)
                
                    lideresanteriores.each do |lider|
                        lider.estatus=false
                        lider.save
                    end                    
                end        
        else
            lider= Lider.create(cliente_id: cliente.id, ruta_id: ruta.id, record: recordcliente, estatus: true)
        end
    end
    

    #Aumentar puntos al cliente
    def aumenta_puntos(cliente,puntos)
    cliente.puntaje=cliente.puntaje+puntos
    cliente.save
	end

	#Aumenta kilometraje al cliente
	def aumenta_kilometraje(reservacion)
		# reservacion.cliente.kilometraje=reservacion.cliente.kilometraje+reservacion.viaje.ruta.kilometros
        reservacion.cliente.kilometros=reservacion.cliente.kilometros+calcular_distancia(reservacion)
		reservacion.cliente.save
	end

    #Si la van va llena se multiplica por dos los puntos del kilometraje
	def aumenta_puntos_kilometraje(reservacion)
		if (valida_van_llena(reservacion.viaje.ruta.van, reservacion.viaje))
			# aumenta_puntos(reservacion.cliente,reservacion.viaje.ruta.kilometros*10*2)
            aumenta_puntos(reservacion.cliente,calcular_distancia(reservacion)*10*2)
		else
            aumenta_puntos(reservacion.cliente,calcular_distancia(reservacion)*10)
			# aumenta_puntos(reservacion.cliente,reservacion.viaje.ruta.kilometros*10)
		end
	end


	#Calculo de CO2
	def calcula_co2(reservacion)
    	co2emitido=calcula_co2_viaje(reservacion)
        #corregir 
    	reservacion.cliente.emisionco2= reservacion.cliente.emisionco2.to_f+co2emitido
    	reservacion.cliente.save
	end

    def calcula_co2_viaje(reservacion)
        return (calcular_distancia(reservacion)*(Configuracion.find(9).valor.to_f/1000))/Reservacion.find_all_by_estadotipo_id_and_viaje_id([2,3],reservacion.viaje_id).count
    end

     def calcula_co2ahorrado(cliente)
       current_cliente=cliente
       co2emitido = current_cliente.emisionco2.to_f
       co2auto =current_cliente.kilometros.to_f*(Configuracion.find(1).valor.to_f/1000)

       return co2auto-co2emitido
    end

    def calcula_co2_total
        sumaco2=Cliente.sum(:emisionco2)
        sumakm=Cliente.sum(:kilometros)
        compara=sumakm.to_f*(Configuracion.find(1).valor.to_f/1000)
        return compara-sumaco2
    end

    def tabla_lideres(current_cliente)
        @top=Cliente.order('puntaje DESC').where('puntaje >= ?',current_cliente.puntaje).last(2)
        @bot=Cliente.order('puntaje DESC').where('puntaje < ?',current_cliente.puntaje).first(2)

    if(@top.count==1) 
    @bot=Cliente.order('puntaje DESC').where('puntaje < ?',current_cliente.puntaje).first(3)
    end
    if(@top.count==0)
    @bot=Cliente.order('puntaje DESC').where('puntaje < ?',current_cliente.puntaje).first(4)
    end
    if(@bot.count==1)
      @top=Cliente.order('puntaje DESC').where('puntaje >= ?',current_cliente.puntaje).last(3)
    end
    if(@bot.count==0)
      @top=Cliente.order('puntaje DESC').where('puntaje >= ?',current_cliente.puntaje).last(4)
    end
    end

    def tabla_lideres_facebook(current_cliente, clientes)
        @top=clientes.order('puntaje DESC').where('puntaje >= ?',current_cliente.puntaje).last(2)
        @bot=clientes.order('puntaje DESC').where('puntaje < ?',current_cliente.puntaje).first(2)

    if(@top.count==1) 
    @bot=clientes.order('puntaje DESC').where('puntaje < ?',current_cliente.puntaje).first(3)
    end
    if(@top.count==0)
    @bot=clientes.order('puntaje DESC').where('puntaje < ?',current_cliente.puntaje).first(4)
    end
    if(@bot.count==1)
      @top=clientes.order('puntaje DESC').where('puntaje >= ?',current_cliente.puntaje).last(3)
    end
    if(@bot.count==0)
      @top=clientes.order('puntaje DESC').where('puntaje >= ?',current_cliente.puntaje).last(4)
    end
    end


end