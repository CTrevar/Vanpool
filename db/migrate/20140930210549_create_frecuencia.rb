class CreateFrecuencia < ActiveRecord::Migration
  def change
    create_table :frecuencias do |t|
      t.boolean :lunes
      t.boolean :martes
      t.boolean :miercoles
      t.boolean :jueves
      t.boolean :viernes
      t.boolean :sabado
      t.boolean :viernes
      t.boolean :domingo
      t.integer :ruta_id

      t.timestamps
    end
  end
end
