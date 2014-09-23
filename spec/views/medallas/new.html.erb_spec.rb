require 'spec_helper'

describe "medallas/new" do
  before(:each) do
    assign(:medalla, stub_model(Medalla).as_new_record)
  end

  it "renders new medalla form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => medallas_path, :method => "post" do
    end
  end
end
