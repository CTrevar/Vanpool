require 'spec_helper'

describe "descuentos/index" do
  before(:each) do
    assign(:descuentos, [
      stub_model(Descuento,
        :nombre => "Nombre",
        :descripcion => "Descripcion",
        :porcentaje => "",
        :vigencia => "",
        :medalla_id => 1,
        :estatus => false
      ),
      stub_model(Descuento,
        :nombre => "Nombre",
        :descripcion => "Descripcion",
        :porcentaje => "",
        :vigencia => "",
        :medalla_id => 1,
        :estatus => false
      )
    ])
  end

  it "renders a list of descuentos" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Nombre".to_s, :count => 2
    assert_select "tr>td", :text => "Descripcion".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
