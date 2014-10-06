class ViajesController < ApplicationController
 
  def detalleviaje
    @current_cliente = obtener_cliente(current_user)
    @title = params[:id]
    render 'show_detalleviaje'
  end

end
