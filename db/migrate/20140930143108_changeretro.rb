class Changeretro < ActiveRecord::Migration
	def change
    	add_column :retroalimentacions, :aspecto_id, :integer
    	add_column :retroalimentacions, :calificacion, :integer
  end
end
