require 'spec_helper'

describe "tipo_medallas/show" do
  before(:each) do
    @tipo_medalla = assign(:tipo_medalla, stub_model(TipoMedalla,
      :nombre => "Nombre"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Nombre/)
  end
end
