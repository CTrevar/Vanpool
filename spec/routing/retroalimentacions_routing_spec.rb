require "spec_helper"

describe RetroalimentacionsController do
  describe "routing" do

    it "routes to #index" do
      get("/retroalimentacions").should route_to("retroalimentacions#index")
    end

    it "routes to #new" do
      get("/retroalimentacions/new").should route_to("retroalimentacions#new")
    end

    it "routes to #show" do
      get("/retroalimentacions/1").should route_to("retroalimentacions#show", :id => "1")
    end

    it "routes to #edit" do
      get("/retroalimentacions/1/edit").should route_to("retroalimentacions#edit", :id => "1")
    end

    it "routes to #create" do
      post("/retroalimentacions").should route_to("retroalimentacions#create")
    end

    it "routes to #update" do
      put("/retroalimentacions/1").should route_to("retroalimentacions#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/retroalimentacions/1").should route_to("retroalimentacions#destroy", :id => "1")
    end

  end
end
