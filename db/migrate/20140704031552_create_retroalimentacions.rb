class CreateRetroalimentacions < ActiveRecord::Migration
  def change
    create_table :retroalimentacions do |t|
      t.integer :reservacion_id
      t.integer :retroaspecto_id
      t.integer :calificacion
      t.integer :aspecto_id	

      t.timestamps
    end
  end
end
