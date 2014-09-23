class CreateMedallasmuros < ActiveRecord::Migration
  def change
    create_table :medallasmuros do |t|
      t.integer :cliente_id
      t.integer :medalla_id
      t.boolean :cobrado

      t.timestamps
    end
  end
end
