class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.integer :heir_id
      t.string :heir_type

      t.timestamps
    end
  end
end
