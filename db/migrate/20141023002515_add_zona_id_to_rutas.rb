class AddZonaIdToRutas < ActiveRecord::Migration
  def change
    add_column :rutas, :zona_id, :integer
  end
end
