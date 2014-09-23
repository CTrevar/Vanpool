require "spec_helper"

describe MedallasController do
  describe "routing" do

    it "routes to #index" do
      get("/medallas").should route_to("medallas#index")
    end

    it "routes to #new" do
      get("/medallas/new").should route_to("medallas#new")
    end

    it "routes to #show" do
      get("/medallas/1").should route_to("medallas#show", :id => "1")
    end

    it "routes to #edit" do
      get("/medallas/1/edit").should route_to("medallas#edit", :id => "1")
    end

    it "routes to #create" do
      post("/medallas").should route_to("medallas#create")
    end

    it "routes to #update" do
      put("/medallas/1").should route_to("medallas#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/medallas/1").should route_to("medallas#destroy", :id => "1")
    end

  end
end
