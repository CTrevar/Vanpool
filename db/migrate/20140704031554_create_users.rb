class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :provider
      t.string :uid
      t.boolean :admin, :default => false
      t.boolean :estatusUsuario, :default => true
      t.datetime :fechaNacimiento
      t.string :apellidoPaterno
      t.string :apellidoMaterno

      t.timestamps
    end
  end
end
