class CreateMedallas < ActiveRecord::Migration
  def change
    create_table :medallas do |t|
      t.integer :tipomedalla_id
      t.string  :nombre
      t.integer :puntos
      t.string  :imagen
      t.boolean :estatus, :default => true
      t.integer :estado, :default => 0
      t.string :descripcion
    
      t.timestamps
    end
  end
end
