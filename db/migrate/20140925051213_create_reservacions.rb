class CreateReservacions < ActiveRecord::Migration
  def change
    create_table :reservacions do |t|
      t.integer :viaje_id
      t.integer :cliente_id
      t.integer :referenciapago_id
      t.integer :estadotipo_id
      t.boolean :estatus

      t.timestamps
    end
  end
end
