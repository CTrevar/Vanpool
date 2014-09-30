require 'spec_helper'

describe "retroalimentacions/show" do
  before(:each) do
    @retroalimentacion = assign(:retroalimentacion, stub_model(Retroalimentacion,
      :reservacion_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
