module CheckinHelper

	def checkin
		#agregar rollback
    	@reservacion = Reservacion.find(params[:id])
 		reservacion_realizada(@reservacion)
    	aumenta_kilometraje(@reservacion)
    	aumenta_puntos_kilometraje(@reservacion)
    	calcula_co2(@reservacion)
    	asigna_medalla_viaje(@reservacion.cliente)
    	cambio_nivel(@reservacion.cliente)
    	redirect_to :controller => 'clientes', :action => 'reservaciones'
  	end

end
