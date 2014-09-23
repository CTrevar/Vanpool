require 'spec_helper'

describe "nivels/show" do
  before(:each) do
    @nivel = assign(:nivel, stub_model(Nivel,
      :nombre => "Nombre",
      :rangomaximo => 1,
      :estatus => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Nombre/)
    rendered.should match(/1/)
    rendered.should match(/false/)
  end
end
