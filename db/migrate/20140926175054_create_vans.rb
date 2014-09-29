class CreateVans < ActiveRecord::Migration
  def change
    create_table :vans do |t|
      t.string :placa, :limit => 45
      t.string :modelo, :limit => 45
      t.integer :capacidad
      t.integer :co2gxkm
      t.date :fecha_compra
      t.integer :kilometro_recorrido
      t.boolean :activa
      t.boolean :estatus
      t.references :pais

      t.timestamps
    end
    add_index :vans, :pais_id
  end
end
