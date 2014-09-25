require 'spec_helper'

describe "reservacions/index" do
  before(:each) do
    assign(:reservacions, [
      stub_model(Reservacion,
        :viaje_id => 1,
        :cliente_id => 2,
        :referenciapago_id => 3,
        :estadostipo => 4,
        :estatus => false
      ),
      stub_model(Reservacion,
        :viaje_id => 1,
        :cliente_id => 2,
        :referenciapago_id => 3,
        :estadostipo => 4,
        :estatus => false
      )
    ])
  end

  it "renders a list of reservacions" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
