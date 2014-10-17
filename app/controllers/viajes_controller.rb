class ViajesController < ApplicationController
 
  def detalle
    @current_cliente = obtener_cliente(current_user)
    @title = params[:id]
    @viaje=Viaje.find(params[:id])
    render 'show_detalleviaje'
  end

end
