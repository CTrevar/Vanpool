class CreateRutaparadas < ActiveRecord::Migration
  def change
    create_table :rutaparadas do |t|
      t.integer :posicion
      t.float :tiempo
      t.float :distancia
      t.integer :ruta_id
      t.integer :parada_id

      t.timestamps
    end
  end
end
