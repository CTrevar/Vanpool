class AddImagenmedallaToMedallas < ActiveRecord::Migration
  def change
  	add_column :medallas, :imagenmedalla, :attachment
  end
end
