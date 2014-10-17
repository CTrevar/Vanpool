class AddLatitudeAndLongitudeToModel < ActiveRecord::Migration
  def change
    add_column :paradas, :latitude, :float
    add_column :paradas, :longitude, :float
  end
end
