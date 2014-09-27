module CheckinHelper

	def checkin
    	 @reservacion = Reservacion.find(params[:id])
    #cambiar estado de reservacion
    @reservacion.estadotipo_id=3
    
    ##aumentapuntoskilometroa
    
    #aumentar kilometraje
    @reservacion.cliente.kilometraje=@reservacion.cliente.kilometraje+@reservacion.viaje.ruta.kilometros
    
    #calculo co2 por viaje
    vanco2=@reservacion.viaje.ruta.kilometros*(@reservacion.viaje.ruta.van.co2gxkm/Reservacion.find_all_by_estadotipo_id_and_viaje_id(2,@reservacion.viaje_id).count)
    #autoco2=@reservacion.viaje.ruta.kilometros*Configuracion.find_by_nombre("CO2gxkmauto").valor
    autoco2=@reservacion.viaje.ruta.kilometros*196
    @reservacion.cliente.co2=autoco2-vanco2

   	cambio_nivel(@reservacion.cliente)

    @reservacion.save
    #@reservacion.cliente.save

    asigna_medalla_viaje(@reservacion.cliente)
    
    redirect_to :controller => 'clientes', :action => 'reservaciones'
  	end

end
