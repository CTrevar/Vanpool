require 'spec_helper'

describe "nivels/index" do
  before(:each) do
    assign(:nivels, [
      stub_model(Nivel,
        :nombre => "Nombre",
        :rangomaximo => 1,
        :estatus => false
      ),
      stub_model(Nivel,
        :nombre => "Nombre",
        :rangomaximo => 1,
        :estatus => false
      )
    ])
  end

  it "renders a list of nivels" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Nombre".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
