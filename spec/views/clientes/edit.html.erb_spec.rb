require 'spec_helper'

describe "clientes/edit" do
  before(:each) do
    @cliente = assign(:cliente, stub_model(Cliente,
      :puntaje => 1,
      :nivel => 1
    ))
  end

  it "renders the edit cliente form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => clientes_path(@cliente), :method => "post" do
      assert_select "input#cliente_puntaje", :name => "cliente[puntaje]"
      assert_select "input#cliente_nivel", :name => "cliente[nivel]"
    end
  end
end
