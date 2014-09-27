require 'spec_helper'

describe "reservacions/new" do
  before(:each) do
    assign(:reservacion, stub_model(Reservacion,
      :viaje_id => 1,
      :cliente_id => 1,
      :referenciapago_id => 1,
      :estadostipo => 1,
      :estatus => false
    ).as_new_record)
  end

  it "renders new reservacion form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => reservacions_path, :method => "post" do
      assert_select "input#reservacion_viaje_id", :name => "reservacion[viaje_id]"
      assert_select "input#reservacion_cliente_id", :name => "reservacion[cliente_id]"
      assert_select "input#reservacion_referenciapago_id", :name => "reservacion[referenciapago_id]"
      assert_select "input#reservacion_estadostipo", :name => "reservacion[estadostipo]"
      assert_select "input#reservacion_estatus", :name => "reservacion[estatus]"
    end
  end
end
