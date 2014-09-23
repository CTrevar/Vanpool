require 'spec_helper'

describe "tipomedallas/edit" do
  before(:each) do
    @tipomedalla = assign(:tipomedalla, stub_model(Tipomedalla))
  end

  it "renders the edit tipomedalla form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => tipomedallas_path(@tipomedalla), :method => "post" do
    end
  end
end
