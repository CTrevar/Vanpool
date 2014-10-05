require 'spec_helper'

describe "reportes/show" do
  before(:each) do
    @reporte = assign(:reporte, stub_model(Reporte,
      :cliente_id => 1,
      :descripcion => "Descripcion",
      :estatus => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Descripcion/)
    rendered.should match(/false/)
  end
end
