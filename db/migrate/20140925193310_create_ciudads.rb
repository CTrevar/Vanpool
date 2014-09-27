class CreateCiudads < ActiveRecord::Migration
  def change
    create_table :ciudads do |t|
      t.string :clave, :limit => 45
      t.string :nombre, :limit => 100
      t.boolean :estauts
      t.references :pais

      t.timestamps
    end
    add_index :ciudads, :pais_id
  end
end
