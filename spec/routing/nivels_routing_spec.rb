require "spec_helper"

describe NivelsController do
  describe "routing" do

    it "routes to #index" do
      get("/nivels").should route_to("nivels#index")
    end

    it "routes to #new" do
      get("/nivels/new").should route_to("nivels#new")
    end

    it "routes to #show" do
      get("/nivels/1").should route_to("nivels#show", :id => "1")
    end

    it "routes to #edit" do
      get("/nivels/1/edit").should route_to("nivels#edit", :id => "1")
    end

    it "routes to #create" do
      post("/nivels").should route_to("nivels#create")
    end

    it "routes to #update" do
      put("/nivels/1").should route_to("nivels#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/nivels/1").should route_to("nivels#destroy", :id => "1")
    end

  end
end
