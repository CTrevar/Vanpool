class AddRutaIdToParadas < ActiveRecord::Migration
  def change
    add_column :paradas, :ruta_id, :integer
  end
end
