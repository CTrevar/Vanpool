require 'spec_helper'

describe "reservacions/show" do
  before(:each) do
    @reservacion = assign(:reservacion, stub_model(Reservacion,
      :viaje_id => 1,
      :cliente_id => 2,
      :referenciapago_id => 3,
      :estadostipo => 4,
      :estatus => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/3/)
    rendered.should match(/4/)
    rendered.should match(/false/)
  end
end
