require 'spec_helper'

describe "retroalimentacions/new" do
  before(:each) do
    assign(:retroalimentacion, stub_model(Retroalimentacion,
      :reservacion_id => 1
    ).as_new_record)
  end

  it "renders new retroalimentacion form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => retroalimentacions_path, :method => "post" do
      assert_select "input#retroalimentacion_reservacion_id", :name => "retroalimentacion[reservacion_id]"
    end
  end
end
