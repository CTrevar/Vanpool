class CreateParadaRuta < ActiveRecord::Migration
  def change
    create_table :parada_ruta do |t|
      t.integer :posicion
      t.integer :tiempo
      t.double :distancia
      t.text :via_puntos

      t.timestamps
    end
  end
end
