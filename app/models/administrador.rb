class Administrador < ActiveRecord::Base
  attr_accessible :apellidoMaterno, :apellidoPaterno, :emailUsuario, :estatusUsuario, :facebookidUsuario, :fechaNacimiento, :idTipoUsuario, :nombrePilaUsuario, :nombreUsuario, :openpayidUsuario
  validates :nombrePilaUsuario, :apellidoPaterno, :apellidoMaterno, :emailUsuario, presence: true
end
