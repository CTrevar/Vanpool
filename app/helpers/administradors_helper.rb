module AdministradorsHelper

	
	def clientes_top5
		return Cliente.where(:estatus=>true).order("puntaje DESC").limit(5)
	end

	def clientes_lideres_rutas
		lideres=Array.new
		rutasconlider=Lider.where(:estatus=>true)
		rutasconlider.each do |ruta|
			lideres<< Lider.where(:ruta_id=>ruta.id, :estatus=>true).first
		end
		
		return lideres.last(5)
	end

	
end
