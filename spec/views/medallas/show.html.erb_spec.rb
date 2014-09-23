require 'spec_helper'

describe "medallas/show" do
  before(:each) do
    @medalla = assign(:medalla, stub_model(Medalla))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
