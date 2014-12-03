class CreateShares < ActiveRecord::Migration
  def change
    create_table :shares do |t|
      t.integer :reservacion_id
      t.timestamps
    end
  end
end