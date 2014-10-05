class ChangeUser < ActiveRecord::Migration
  def up
    add_column :users, :idTipoUsuario, :integer
    add_column :users, :facebookidUsuario, :string
    add_column :users, :openpayidUsuario, :string
    add_column :users, :apellidoPaterno, :string
    add_column :users, :apellidoMaterno, :string
    add_column :users, :fechaNacimiento, :datetime
    add_column :users, :estatusUsuario, :boolean
  end

  def down
  end
end
