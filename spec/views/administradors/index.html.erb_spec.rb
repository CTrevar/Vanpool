require 'spec_helper'

describe "administradors/index" do
  before(:each) do
    assign(:administradors, [
      stub_model(Administrador,
        :nombreUsuario => "Nombre Usuario",
        :emailUsuario => "Email Usuario",
        :idTipoUsuario => 1,
        :facebookidUsuario => "Facebookid Usuario",
        :openpayidUsuario => "Openpayid Usuario",
        :nombrePilaUsuario => "Nombre Pila Usuario",
        :apellidoPaterno => "Apellido Paterno",
        :apellidoMaterno => "Apellido Materno",
        :estatusUsuario => false
      ),
      stub_model(Administrador,
        :nombreUsuario => "Nombre Usuario",
        :emailUsuario => "Email Usuario",
        :idTipoUsuario => 1,
        :facebookidUsuario => "Facebookid Usuario",
        :openpayidUsuario => "Openpayid Usuario",
        :nombrePilaUsuario => "Nombre Pila Usuario",
        :apellidoPaterno => "Apellido Paterno",
        :apellidoMaterno => "Apellido Materno",
        :estatusUsuario => false
      )
    ])
  end

  it "renders a list of administradors" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Nombre Usuario".to_s, :count => 2
    assert_select "tr>td", :text => "Email Usuario".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Facebookid Usuario".to_s, :count => 2
    assert_select "tr>td", :text => "Openpayid Usuario".to_s, :count => 2
    assert_select "tr>td", :text => "Nombre Pila Usuario".to_s, :count => 2
    assert_select "tr>td", :text => "Apellido Paterno".to_s, :count => 2
    assert_select "tr>td", :text => "Apellido Materno".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
