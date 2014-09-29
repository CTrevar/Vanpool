module ReservacionsHelper

	def reservacion_realizada(reservacion)
		reservacion.estadotipo_id=3
		reservacion.save
	end

end
