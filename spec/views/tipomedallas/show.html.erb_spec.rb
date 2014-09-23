require 'spec_helper'

describe "tipomedallas/show" do
  before(:each) do
    @tipomedalla = assign(:tipomedalla, stub_model(Tipomedalla))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
