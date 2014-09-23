require "spec_helper"

describe TipomedallasController do
  describe "routing" do

    it "routes to #index" do
      get("/tipomedallas").should route_to("tipomedallas#index")
    end

    it "routes to #new" do
      get("/tipomedallas/new").should route_to("tipomedallas#new")
    end

    it "routes to #show" do
      get("/tipomedallas/1").should route_to("tipomedallas#show", :id => "1")
    end

    it "routes to #edit" do
      get("/tipomedallas/1/edit").should route_to("tipomedallas#edit", :id => "1")
    end

    it "routes to #create" do
      post("/tipomedallas").should route_to("tipomedallas#create")
    end

    it "routes to #update" do
      put("/tipomedallas/1").should route_to("tipomedallas#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/tipomedallas/1").should route_to("tipomedallas#destroy", :id => "1")
    end

  end
end
