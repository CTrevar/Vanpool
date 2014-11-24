class CreateReservacions < ActiveRecord::Migration
  def change
    create_table :reservacions do |t|
      t.integer :viaje_id
      t.integer :cliente_id
      t.string :referenciapago_id
      t.integer :estadotipo_id, :default =>1
      t.boolean :estatus, :default =>true

      t.timestamps
    end
  end
end
