class CreateSugerenciaparadas < ActiveRecord::Migration
  def change
    create_table :sugerenciaparadas do |t|
      t.decimal :latitud
      t.decimal :longitud
      t.integer :posicion
      t.integer :sugerencia_id
	  t.string :nombre
	  
      t.timestamps
    end
  end
end
