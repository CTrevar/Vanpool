require 'spec_helper'

describe "Reservacions" do
  describe "GET /reservacions" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get reservacions_path
      response.status.should be(200)
    end
  end
end
