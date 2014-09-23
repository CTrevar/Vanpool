require 'spec_helper'

describe "tipomedallas/new" do
  before(:each) do
    assign(:tipomedalla, stub_model(Tipomedalla).as_new_record)
  end

  it "renders new tipomedalla form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => tipomedallas_path, :method => "post" do
    end
  end
end
