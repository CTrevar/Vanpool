require 'spec_helper'

describe "tipo_medallas/index" do
  before(:each) do
    assign(:tipo_medallas, [
      stub_model(TipoMedalla,
        :nombre => "Nombre"
      ),
      stub_model(TipoMedalla,
        :nombre => "Nombre"
      )
    ])
  end

  it "renders a list of tipo_medallas" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Nombre".to_s, :count => 2
  end
end
