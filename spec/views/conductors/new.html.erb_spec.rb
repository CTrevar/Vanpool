require 'spec_helper'

describe "conductors/new" do
  before(:each) do
    assign(:conductor, stub_model(Conductor,
      :user_id => 1,
      :licenciaConductor => "MyString",
      :estatusConductor => false
    ).as_new_record)
  end

  it "renders new conductor form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => conductors_path, :method => "post" do
      assert_select "input#conductor_user_id", :name => "conductor[user_id]"
      assert_select "input#conductor_licenciaConductor", :name => "conductor[licenciaConductor]"
      assert_select "input#conductor_estatusConductor", :name => "conductor[estatusConductor]"
    end
  end
end
