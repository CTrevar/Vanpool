require 'spec_helper'

describe "tipo_medallas/edit" do
  before(:each) do
    @tipo_medalla = assign(:tipo_medalla, stub_model(TipoMedalla,
      :nombre => "MyString"
    ))
  end

  it "renders the edit tipo_medalla form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => tipo_medallas_path(@tipo_medalla), :method => "post" do
      assert_select "input#tipo_medalla_nombre", :name => "tipo_medalla[nombre]"
    end
  end
end
