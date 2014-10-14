module AdministradorsHelper

	def cantidad_clientes
		return Cliente.all.count
	end

	def viajes_realizados_vs_cancelados
		return (num_viajes_realizados/(num_viajes_realizados+num_viajes_cancelados))*100
	end

	def reservaciones_realizados_vs_cancelados
		return (num_reservas_vendidas/(num_reservas_vendidas+num_reservas_canceladas))*100
	end

	def co2ahorrado
		return Cliente.sum(:co2).to_d/1000
	end

	def kilometros_vans
		return Viaje.joins(:ruta).where(:estadoviaje_id=>3).sum(:kilometros).to_d
	end

	def clientes_top10
		return Cliente.order("puntaje DESC").limit(5)
	end

	def num_rutas
		return Ruta.find_all_by_estatus(true).count
	end

	def num_viajes_realizados
		return Viaje.find_all_by_estadoviaje_id(3).count
	end

	def num_viajes_cancelados
		return Viaje.find_all_by_estadoviaje_id(4).count
	end

	def num_viajes_pendientes
		return Viaje.find_all_by_estadoviaje_id(1).count
	end

	def num_reservas_vendidas
		return Reservacion.find_all_by_estadotipo_id([2,3]).count
	end

	def num_reservas_canceladas
		return Reservacion.find_all_by_estadotipo_id(4).count
	end

	def ventas_mensuales
		return 0
		#openpay
		#meses=Reservacion.find_all_by_estadotipo_id([2,3]).group_by { |m| m.created_at.beginning_of_month }
		
	end

	def ruta_popular
		return 0
	end

	def num_vans_activas
		return Van.find_all_by_estatus_and_activa(true,true).count
	end

	def num_vans_inactivas
		return Van.find_all_by_estatus_and_activa(true,false).count
	end

end
