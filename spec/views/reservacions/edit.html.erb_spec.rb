require 'spec_helper'

describe "reservacions/edit" do
  before(:each) do
    @reservacion = assign(:reservacion, stub_model(Reservacion,
      :viaje_id => 1,
      :cliente_id => 1,
      :referenciapago_id => 1,
      :estadostipo => 1,
      :estatus => false
    ))
  end

  it "renders the edit reservacion form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => reservacions_path(@reservacion), :method => "post" do
      assert_select "input#reservacion_viaje_id", :name => "reservacion[viaje_id]"
      assert_select "input#reservacion_cliente_id", :name => "reservacion[cliente_id]"
      assert_select "input#reservacion_referenciapago_id", :name => "reservacion[referenciapago_id]"
      assert_select "input#reservacion_estadostipo", :name => "reservacion[estadostipo]"
      assert_select "input#reservacion_estatus", :name => "reservacion[estatus]"
    end
  end
end
