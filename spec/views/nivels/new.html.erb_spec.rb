require 'spec_helper'

describe "nivels/new" do
  before(:each) do
    assign(:nivel, stub_model(Nivel,
      :nombre => "MyString",
      :rangomaximo => 1,
      :estatus => false
    ).as_new_record)
  end

  it "renders new nivel form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => nivels_path, :method => "post" do
      assert_select "input#nivel_nombre", :name => "nivel[nombre]"
      assert_select "input#nivel_rangomaximo", :name => "nivel[rangomaximo]"
      assert_select "input#nivel_estatus", :name => "nivel[estatus]"
    end
  end
end
