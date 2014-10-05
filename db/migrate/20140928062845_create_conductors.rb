class CreateConductors < ActiveRecord::Migration
  def change
    create_table :conductors do |t|
      t.integer :user_id
      t.string :licenciaConductor
      t.boolean :estatusConductor
      t.belongs_to :user

      t.timestamps
    end
  end
end
