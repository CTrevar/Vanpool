class CreateDescuentos < ActiveRecord::Migration
  def change
    create_table :descuentos do |t|
      t.string :nombre
      t.string :descripcion
      t.integer :porcentaje
      t.integer :vigencia
      t.integer :medalla_id
      t.boolean :estatus

      t.timestamps
    end
  end
end
