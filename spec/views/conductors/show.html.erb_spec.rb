require 'spec_helper'

describe "conductors/show" do
  before(:each) do
    @conductor = assign(:conductor, stub_model(Conductor,
      :user_id => 1,
      :licenciaConductor => "Licencia Conductor",
      :estatusConductor => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Licencia Conductor/)
    rendered.should match(/false/)
  end
end
