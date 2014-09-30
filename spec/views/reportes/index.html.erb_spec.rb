require 'spec_helper'

describe "reportes/index" do
  before(:each) do
    assign(:reportes, [
      stub_model(Reporte,
        :cliente_id => 1,
        :descripcion => "Descripcion",
        :estatus => false
      ),
      stub_model(Reporte,
        :cliente_id => 1,
        :descripcion => "Descripcion",
        :estatus => false
      )
    ])
  end

  it "renders a list of reportes" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Descripcion".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
