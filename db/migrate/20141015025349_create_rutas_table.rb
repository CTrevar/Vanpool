class CreateRutasTable < ActiveRecord::Migration
def change
    create_table :rutas do |t|
      t.integer :conductor_id
      t.integer :van_id
      t.string :nombre
      t.string :gmaps
      t.string :precio
      t.integer :kilometros
      t.boolean :estatus

      t.timestamps
    end
end
end
