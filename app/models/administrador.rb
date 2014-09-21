class Administrador < ActiveRecord::Base
  attr_accessible :apellidoMaterno, :apellidoPaterno, :emailUsuario, :estatusUsuario, :facebookidUsuario, :fechaNacimiento, :idTipoUsuario, :nombrePilaUsuario, :nombreUsuario, :openpayidUsuario
end
