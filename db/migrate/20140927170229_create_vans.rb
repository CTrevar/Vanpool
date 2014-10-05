class CreateVans < ActiveRecord::Migration
  def change
    create_table :vans do |t|
    	t.string :placa
    	t.string :modelo
    	t.integer :capacidad
    	t.integer :co2gxkm
    	t.integer :pais_id
      	t.date :fechacompra
      	t.boolean :activa	
      	t.boolean :estatus

      t.timestamps
    end
  end
end
