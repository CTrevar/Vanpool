require 'spec_helper'

describe "retroaspectos/show" do
  before(:each) do
    @retroaspecto = assign(:retroaspecto, stub_model(Retroaspecto,
      :nombre => "Nombre",
      :estatus => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Nombre/)
    rendered.should match(/false/)
  end
end
