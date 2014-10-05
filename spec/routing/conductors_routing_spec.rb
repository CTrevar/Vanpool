require "spec_helper"

describe ConductorsController do
  describe "routing" do

    it "routes to #index" do
      get("/conductors").should route_to("conductors#index")
    end

    it "routes to #new" do
      get("/conductors/new").should route_to("conductors#new")
    end

    it "routes to #show" do
      get("/conductors/1").should route_to("conductors#show", :id => "1")
    end

    it "routes to #edit" do
      get("/conductors/1/edit").should route_to("conductors#edit", :id => "1")
    end

    it "routes to #create" do
      post("/conductors").should route_to("conductors#create")
    end

    it "routes to #update" do
      put("/conductors/1").should route_to("conductors#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/conductors/1").should route_to("conductors#destroy", :id => "1")
    end

  end
end
