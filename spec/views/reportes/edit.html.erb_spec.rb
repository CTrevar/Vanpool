require 'spec_helper'

describe "reportes/edit" do
  before(:each) do
    @reporte = assign(:reporte, stub_model(Reporte,
      :cliente_id => 1,
      :descripcion => "MyString",
      :estatus => false
    ))
  end

  it "renders the edit reporte form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => reportes_path(@reporte), :method => "post" do
      assert_select "input#reporte_cliente_id", :name => "reporte[cliente_id]"
      assert_select "input#reporte_descripcion", :name => "reporte[descripcion]"
      assert_select "input#reporte_estatus", :name => "reporte[estatus]"
    end
  end
end
