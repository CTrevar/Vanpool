class ChangeFrecuenciaName < ActiveRecord::Migration
  def change
  	rename_table :frecuencia, :frecuencias
  end
end
