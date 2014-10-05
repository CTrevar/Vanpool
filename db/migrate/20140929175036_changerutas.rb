class Changerutas < ActiveRecord::Migration
  def change
  	rename_table :ruta, :rutas
  end
end
