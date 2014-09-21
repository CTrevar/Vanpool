require 'spec_helper'

describe "administradors/new" do
  before(:each) do
    assign(:administrador, stub_model(Administrador,
      :nombreUsuario => "MyString",
      :emailUsuario => "MyString",
      :idTipoUsuario => 1,
      :facebookidUsuario => "MyString",
      :openpayidUsuario => "MyString",
      :nombrePilaUsuario => "MyString",
      :apellidoPaterno => "MyString",
      :apellidoMaterno => "MyString",
      :estatusUsuario => false
    ).as_new_record)
  end

  it "renders new administrador form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => administradors_path, :method => "post" do
      assert_select "input#administrador_nombreUsuario", :name => "administrador[nombreUsuario]"
      assert_select "input#administrador_emailUsuario", :name => "administrador[emailUsuario]"
      assert_select "input#administrador_idTipoUsuario", :name => "administrador[idTipoUsuario]"
      assert_select "input#administrador_facebookidUsuario", :name => "administrador[facebookidUsuario]"
      assert_select "input#administrador_openpayidUsuario", :name => "administrador[openpayidUsuario]"
      assert_select "input#administrador_nombrePilaUsuario", :name => "administrador[nombrePilaUsuario]"
      assert_select "input#administrador_apellidoPaterno", :name => "administrador[apellidoPaterno]"
      assert_select "input#administrador_apellidoMaterno", :name => "administrador[apellidoMaterno]"
      assert_select "input#administrador_estatusUsuario", :name => "administrador[estatusUsuario]"
    end
  end
end
