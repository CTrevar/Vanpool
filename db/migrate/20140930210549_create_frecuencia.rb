class CreateFrecuencia < ActiveRecord::Migration
  def change
    create_table :frecuencia do |t|
      t.boolean :lunes
      t.boolean :martes
      t.boolean :miercoles
      t.boolean :jueves
      t.boolean :viernes
      t.boolean :sabado
      t.boolean :viernes

      t.timestamps
    end
  end
end
