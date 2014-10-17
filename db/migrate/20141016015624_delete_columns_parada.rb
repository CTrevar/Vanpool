class DeleteColumnsParada < ActiveRecord::Migration
def change
  	remove_column :paradas, :posicion
  	remove_column :paradas, :distancia
  	remove_column :paradas, :tiempo
  	remove_column :paradas, :ruta_id
  end
end
