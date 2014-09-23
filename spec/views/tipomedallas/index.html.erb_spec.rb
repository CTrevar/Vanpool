require 'spec_helper'

describe "tipomedallas/index" do
  before(:each) do
    assign(:tipomedallas, [
      stub_model(Tipomedalla),
      stub_model(Tipomedalla)
    ])
  end

  it "renders a list of tipomedallas" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
