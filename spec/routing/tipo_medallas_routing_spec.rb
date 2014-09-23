require "spec_helper"

describe TipoMedallasController do
  describe "routing" do

    it "routes to #index" do
      get("/tipo_medallas").should route_to("tipo_medallas#index")
    end

    it "routes to #new" do
      get("/tipo_medallas/new").should route_to("tipo_medallas#new")
    end

    it "routes to #show" do
      get("/tipo_medallas/1").should route_to("tipo_medallas#show", :id => "1")
    end

    it "routes to #edit" do
      get("/tipo_medallas/1/edit").should route_to("tipo_medallas#edit", :id => "1")
    end

    it "routes to #create" do
      post("/tipo_medallas").should route_to("tipo_medallas#create")
    end

    it "routes to #update" do
      put("/tipo_medallas/1").should route_to("tipo_medallas#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/tipo_medallas/1").should route_to("tipo_medallas#destroy", :id => "1")
    end

  end
end
