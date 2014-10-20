class RenameSugerencia < ActiveRecord::Migration
  def up
  	rename_table :sugerencia, :sugerencias
  end

  def down
  	rename_table :sugerencia, :sugerencias
  end
end
