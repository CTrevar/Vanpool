require 'spec_helper'

describe "retroaspectos/index" do
  before(:each) do
    assign(:retroaspectos, [
      stub_model(Retroaspecto,
        :nombre => "Nombre",
        :estatus => false
      ),
      stub_model(Retroaspecto,
        :nombre => "Nombre",
        :estatus => false
      )
    ])
  end

  it "renders a list of retroaspectos" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Nombre".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
