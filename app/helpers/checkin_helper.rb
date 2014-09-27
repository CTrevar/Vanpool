module CheckinHelper

	def checkin
    	 @reservacion = Reservacion.find(params[:id])
    #cambiar estado de reservacion
    @reservacion.estadotipo_id=3
    
    #aumenar puntaje
    @reservacion.cliente.puntaje=@reservacion.cliente.puntaje+5000
    
    #aumentar kilometraje
    @reservacion.cliente.kilometraje=@reservacion.cliente.kilometraje+@reservacion.viaje.ruta.kilometros
    
    #calculo co2 por viaje
    vanco2=@reservacion.viaje.ruta.kilometros*(@reservacion.viaje.ruta.van.co2gxkm/Reservacion.find_all_by_estadotipo_id_and_viaje_id(2,@reservacion.viaje_id).count)
    #autoco2=@reservacion.viaje.ruta.kilometros*Configuracion.find_by_nombre("CO2gxkmauto").valor
    autoco2=@reservacion.viaje.ruta.kilometros*196
    @reservacion.cliente.co2=autoco2-vanco2

    #cambio de nivel
    if(@reservacion.cliente.puntaje>14999)then
      @reservacion.cliente.nivel_id=2
    end

    @reservacion.save
    @reservacion.cliente.save

    #Dar medalla
    if(obtener_cliente(current_user).reservacions.find_all_by_estadotipo_id(3).count  ==1) then
      @medallamuro = Medallasmuro.create(cliente_id:obtener_cliente(current_user).id,medalla_id:1)
      @medallamuro.save
    end
    
    redirect_to :controller => 'clientes', :action => 'reservaciones'
  	end

end
