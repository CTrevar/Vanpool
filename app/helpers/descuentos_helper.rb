module DescuentosHelper

	def obtener_ultimo_descuento(cliente)
		medalla=cliente.medallasmuros.find_by_cobrado(false)
		#medallas.each do |medalla|
		descuento=Descuento.find_last_by_medalla_id(medalla.medalla_id)
		#end
      return descuento
    end

    def obtener_descuento(cliente)
    	#medalla has descuento?? existe??
    	#listar todas las medallas que tengan descuento
		medalla=cliente.medallasmuros.find_by_cobrado(false)
		#medallas.each do |medalla|
		descuento=Descuento.find_by_medalla_id(medalla.id)
		#end
      return descuento
    end

    def valida_promociones(cliente)
    	return true
    end

end
