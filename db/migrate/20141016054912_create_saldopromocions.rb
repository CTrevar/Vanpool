class CreateSaldopromocions < ActiveRecord::Migration
  def change
    create_table :saldopromocions do |t|
      t.string :nombre
      t.string :descripcion
      t.float :cantidad
      t.string :medalla_id
      t.boolean :estatus

      t.timestamps
    end
  end
end
