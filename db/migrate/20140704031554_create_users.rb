class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :provider
      t.string :uid
      t.boolean :admin, :default => false
      t.boolean :estatusUsuario, :default => true
      t.string :authentication_token 

      t.timestamps
    end
    add_index :users, :authentication_token, :unique => true
  end
end
