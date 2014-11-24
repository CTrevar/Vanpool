module ClientesHelper

	 #Obtener cliente del usuario
    def obtener_cliente(user)
      @cliente = Cliente.find_by_user_id(user.id)
    end

    def numero_clientes
    	return Cliente.where(:estatus=>true).count
    end
    
end
