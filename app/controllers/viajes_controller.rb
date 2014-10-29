class ViajesController < ApplicationController
 
  def detalle
    @current_cliente = obtener_cliente(current_user)
    @title = params[:id]
    @viaje=Viaje.find(params[:id])
    @disponibilidad = calcula_disponibilidad_viaje(@viaje)
    render 'show_detalleviaje'
  end

end
