class CreateRetroalimentacions < ActiveRecord::Migration
  def change
    create_table :retroalimentacions do |t|
      t.integer :reservacion_id
      t.boolean :estatus

      t.timestamps
    end
  end
end
