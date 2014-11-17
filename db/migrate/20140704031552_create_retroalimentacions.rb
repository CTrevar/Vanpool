class CreateRetroalimentacions < ActiveRecord::Migration
  def change
    create_table :retroalimentacions do |t|
      t.integer :reservacion_id
      t.integer :tipocalificacion_id
      t.integer :aspecto_id	

      t.timestamps
    end
  end
end
