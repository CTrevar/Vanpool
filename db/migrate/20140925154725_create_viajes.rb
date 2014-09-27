class CreateViajes < ActiveRecord::Migration
  def change
    create_table :viajes do |t|
      t.integer :ruta_id
      t.string :horainicio
      t.string :fecha
      t.integer :estadoviaje_id
      t.integer :estatus

      t.timestamps
    end
  end
end
