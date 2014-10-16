class CreateHorarios < ActiveRecord::Migration
  def change
    create_table :horarios do |t|
      t.time :hora
      t.integer :ruta_id

      t.timestamps
    end
  end
end
