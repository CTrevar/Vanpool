class CreateRuta < ActiveRecord::Migration
  def change
    create_table :ruta do |t|
      t.string :nombre, :limit => 45
      t.string :gmaps
      t.string :precio, :limit => 45
      t.string :kilometros, :limit => 45
      t.boolean :estatus

      t.timestamps
    end
  end
end
