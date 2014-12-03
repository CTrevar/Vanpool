module AdministradorsHelper

	
	def clientes_top5
		return Cliente.where(:estatus=>true).order("puntaje DESC").limit(5)
	end

	def clientes_lideres_rutas
		lideres=Array.new
		rutasconlider=Lider.where(:estatus=>true)
		rutas=Ruta.all
		#rutas.each do |ruta|
			rutasconlider.each do |lider|
				lideres<< Lider.where(:ruta_id=>lider.ruta.id, :estatus=>true).first
				#lideres<< Lider.first
			end
		#end
		return lideres.last(5)
	end

	
end
