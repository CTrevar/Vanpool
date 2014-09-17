require 'spec_helper'

describe "clientes/new" do
  before(:each) do
    assign(:cliente, stub_model(Cliente,
      :puntaje => 1,
      :nivel => 1
    ).as_new_record)
  end

  it "renders new cliente form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => clientes_path, :method => "post" do
      assert_select "input#cliente_puntaje", :name => "cliente[puntaje]"
      assert_select "input#cliente_nivel", :name => "cliente[nivel]"
    end
  end
end
