module RetroaspectosHelper

	def aspectos
		return Retroaspecto.find_all_by_estatus(true)
	end

end
