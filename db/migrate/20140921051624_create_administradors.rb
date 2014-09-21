class CreateAdministradors < ActiveRecord::Migration
  def change
    create_table :administradors do |t|
      t.string :nombreUsuario
      t.string :emailUsuario
      t.integer :idTipoUsuario
      t.string :facebookidUsuario
      t.string :openpayidUsuario
      t.string :nombrePilaUsuario
      t.string :apellidoPaterno
      t.string :apellidoMaterno
      t.datetime :fechaNacimiento
      t.boolean :estatusUsuario

      t.timestamps
    end
  end
end
