class AddRutaIdToFrecuencias < ActiveRecord::Migration
  def change
    add_column :frecuencias, :ruta_id, :integer
  end
end
