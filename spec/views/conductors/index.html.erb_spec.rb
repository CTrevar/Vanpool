require 'spec_helper'

describe "conductors/index" do
  before(:each) do
    assign(:conductors, [
      stub_model(Conductor,
        :user_id => 1,
        :licenciaConductor => "Licencia Conductor",
        :estatusConductor => false
      ),
      stub_model(Conductor,
        :user_id => 1,
        :licenciaConductor => "Licencia Conductor",
        :estatusConductor => false
      )
    ])
  end

  it "renders a list of conductors" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Licencia Conductor".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
