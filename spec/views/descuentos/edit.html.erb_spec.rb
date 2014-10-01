require 'spec_helper'

describe "descuentos/edit" do
  before(:each) do
    @descuento = assign(:descuento, stub_model(Descuento,
      :nombre => "MyString",
      :descripcion => "MyString",
      :porcentaje => "",
      :vigencia => "",
      :medalla_id => 1,
      :estatus => false
    ))
  end

  it "renders the edit descuento form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => descuentos_path(@descuento), :method => "post" do
      assert_select "input#descuento_nombre", :name => "descuento[nombre]"
      assert_select "input#descuento_descripcion", :name => "descuento[descripcion]"
      assert_select "input#descuento_porcentaje", :name => "descuento[porcentaje]"
      assert_select "input#descuento_vigencia", :name => "descuento[vigencia]"
      assert_select "input#descuento_medalla_id", :name => "descuento[medalla_id]"
      assert_select "input#descuento_estatus", :name => "descuento[estatus]"
    end
  end
end
