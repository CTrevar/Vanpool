class CreateSugerenciaParadas < ActiveRecord::Migration
  def change
    create_table :sugerencia_paradas do |t|
      t.decimal :latitud
      t.decimal :longitud
      t.integer :posicion
      t.integer :sugerencia_id

      t.timestamps
    end
  end
end
