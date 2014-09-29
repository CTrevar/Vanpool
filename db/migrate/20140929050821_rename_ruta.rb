class RenameRuta < ActiveRecord::Migration
  def up
  	rename_table :rutas, :ruta
  end

  def down
  	rename_table :rutas, :ruta
  end
end
