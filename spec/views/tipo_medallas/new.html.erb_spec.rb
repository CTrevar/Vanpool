require 'spec_helper'

describe "tipo_medallas/new" do
  before(:each) do
    assign(:tipo_medalla, stub_model(TipoMedalla,
      :nombre => "MyString"
    ).as_new_record)
  end

  it "renders new tipo_medalla form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => tipo_medallas_path, :method => "post" do
      assert_select "input#tipo_medalla_nombre", :name => "tipo_medalla[nombre]"
    end
  end
end
