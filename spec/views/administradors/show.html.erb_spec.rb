require 'spec_helper'

describe "administradors/show" do
  before(:each) do
    @administrador = assign(:administrador, stub_model(Administrador,
      :nombreUsuario => "Nombre Usuario",
      :emailUsuario => "Email Usuario",
      :idTipoUsuario => 1,
      :facebookidUsuario => "Facebookid Usuario",
      :openpayidUsuario => "Openpayid Usuario",
      :nombrePilaUsuario => "Nombre Pila Usuario",
      :apellidoPaterno => "Apellido Paterno",
      :apellidoMaterno => "Apellido Materno",
      :estatusUsuario => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Nombre Usuario/)
    rendered.should match(/Email Usuario/)
    rendered.should match(/1/)
    rendered.should match(/Facebookid Usuario/)
    rendered.should match(/Openpayid Usuario/)
    rendered.should match(/Nombre Pila Usuario/)
    rendered.should match(/Apellido Paterno/)
    rendered.should match(/Apellido Materno/)
    rendered.should match(/false/)
  end
end
