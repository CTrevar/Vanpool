require 'spec_helper'

describe "descuentos/show" do
  before(:each) do
    @descuento = assign(:descuento, stub_model(Descuento,
      :nombre => "Nombre",
      :descripcion => "Descripcion",
      :porcentaje => "",
      :vigencia => "",
      :medalla_id => 1,
      :estatus => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Nombre/)
    rendered.should match(/Descripcion/)
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(/1/)
    rendered.should match(/false/)
  end
end
