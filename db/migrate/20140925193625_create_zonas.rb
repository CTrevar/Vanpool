class CreateZonas < ActiveRecord::Migration
  def change
    create_table :zonas do |t|
      t.string :clave, :limit => 45
      t.string :nombre, :limit => 100
      t.boolean :estauts
      t.references :ciudad

      t.timestamps
    end
    add_index :zonas, :ciudad_id
  end
end
