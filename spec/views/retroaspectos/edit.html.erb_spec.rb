require 'spec_helper'

describe "retroaspectos/edit" do
  before(:each) do
    @retroaspecto = assign(:retroaspecto, stub_model(Retroaspecto,
      :nombre => "MyString",
      :estatus => false
    ))
  end

  it "renders the edit retroaspecto form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => retroaspectos_path(@retroaspecto), :method => "post" do
      assert_select "input#retroaspecto_nombre", :name => "retroaspecto[nombre]"
      assert_select "input#retroaspecto_estatus", :name => "retroaspecto[estatus]"
    end
  end
end
