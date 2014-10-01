require 'spec_helper'

describe "retroalimentacions/edit" do
  before(:each) do
    @retroalimentacion = assign(:retroalimentacion, stub_model(Retroalimentacion,
      :reservacion_id => 1
    ))
  end

  it "renders the edit retroalimentacion form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => retroalimentacions_path(@retroalimentacion), :method => "post" do
      assert_select "input#retroalimentacion_reservacion_id", :name => "retroalimentacion[reservacion_id]"
    end
  end
end
