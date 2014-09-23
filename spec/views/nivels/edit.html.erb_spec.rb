require 'spec_helper'

describe "nivels/edit" do
  before(:each) do
    @nivel = assign(:nivel, stub_model(Nivel,
      :nombre => "MyString",
      :rangomaximo => 1,
      :estatus => false
    ))
  end

  it "renders the edit nivel form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => nivels_path(@nivel), :method => "post" do
      assert_select "input#nivel_nombre", :name => "nivel[nombre]"
      assert_select "input#nivel_rangomaximo", :name => "nivel[rangomaximo]"
      assert_select "input#nivel_estatus", :name => "nivel[estatus]"
    end
  end
end
