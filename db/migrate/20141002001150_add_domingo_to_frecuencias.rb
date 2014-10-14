class AddDomingoToFrecuencias < ActiveRecord::Migration
  def change
    add_column :frecuencias, :domingo, :boolean
  end
end
