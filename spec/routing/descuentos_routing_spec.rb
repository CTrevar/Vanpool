require "spec_helper"

describe DescuentosController do
  describe "routing" do

    it "routes to #index" do
      get("/descuentos").should route_to("descuentos#index")
    end

    it "routes to #new" do
      get("/descuentos/new").should route_to("descuentos#new")
    end

    it "routes to #show" do
      get("/descuentos/1").should route_to("descuentos#show", :id => "1")
    end

    it "routes to #edit" do
      get("/descuentos/1/edit").should route_to("descuentos#edit", :id => "1")
    end

    it "routes to #create" do
      post("/descuentos").should route_to("descuentos#create")
    end

    it "routes to #update" do
      put("/descuentos/1").should route_to("descuentos#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/descuentos/1").should route_to("descuentos#destroy", :id => "1")
    end

  end
end
