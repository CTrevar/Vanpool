class AddNombreToSugerenciaParadas < ActiveRecord::Migration
  def change
    add_column :sugerencia_paradas, :nombre, :string
  end
end
