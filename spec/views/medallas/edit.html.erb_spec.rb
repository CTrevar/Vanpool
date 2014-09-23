require 'spec_helper'

describe "medallas/edit" do
  before(:each) do
    @medalla = assign(:medalla, stub_model(Medalla))
  end

  it "renders the edit medalla form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => medallas_path(@medalla), :method => "post" do
    end
  end
end
