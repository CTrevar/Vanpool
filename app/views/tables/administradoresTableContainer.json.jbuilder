json.Result "OK"
json.TotalRecordCount @administradors_count
json.Records do
  json.array!(@administradors) do |administrador|
    json.administradors__Emailusuario administrador.Emailusuario
    json.administradors__Idtipousuario administrador.Idtipousuario
    json.administradors__Facebookidusuario administrador.Facebookidusuario
    json.administradors__Openpayidusuario administrador.Openpayidusuario
    json.administradors__Nombrepilausuario administrador.Nombrepilausuario
    json.administradors__Apellidopaterno administrador.Apellidopaterno
    json.administradors__Apellidomaterno administrador.Apellidomaterno
    json.administradors__Fechanacimiento administrador.Fechanacimiento
    json.administradors__Estatususuario administrador.Estatususuario
  end
end