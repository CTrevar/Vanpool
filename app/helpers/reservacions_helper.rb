module ReservacionsHelper

	def reservacion_realizada(reservacion)
		reservacion.estadotipo_id=3
		reservacion.save
	end

	def existe_retroalimentacion(reservacion)
		if(Retroalimentacion.find_all_by_reservacion_id(reservacion.id).count>0)
			return true
		else
			return false
		end
	end

end
