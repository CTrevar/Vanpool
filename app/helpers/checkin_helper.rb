module CheckinHelper

	def checkin id
		#agregar rollback
    	#@reservacion = Reservacion.find(params[:id])
        @reservacion = Reservacion.find(id)
 		reservacion_realizada(@reservacion)
        aumenta_kilometraje(@reservacion)
        aumenta_puntos_kilometraje(@reservacion)
        calcula_co2(@reservacion)
        asigna_medalla_viaje(@reservacion.cliente)
        asigna_medalla_llenototal(@reservacion.cliente)
        cambio_nivel(@reservacion.cliente)
        asigna_lider(@reservacion.cliente, @reservacion.viaje.ruta)
    	  # redirect_to :controller => 'clientes', :action => 'reservaciones'
  	end
end
