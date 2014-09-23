require 'spec_helper'

describe "medallas/index" do
  before(:each) do
    assign(:medallas, [
      stub_model(Medalla),
      stub_model(Medalla)
    ])
  end

  it "renders a list of medallas" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
