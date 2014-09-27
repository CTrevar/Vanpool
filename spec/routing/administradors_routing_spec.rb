require "spec_helper"

describe AdministradorsController do
  describe "routing" do

    it "routes to #index" do
      get("/administradors").should route_to("administradors#index")
    end

    it "routes to #new" do
      get("/administradors/new").should route_to("administradors#new")
    end

    it "routes to #show" do
      get("/administradors/1").should route_to("administradors#show", :id => "1")
    end

    it "routes to #edit" do
      get("/administradors/1/edit").should route_to("administradors#edit", :id => "1")
    end

    it "routes to #create" do
      post("/administradors").should route_to("administradors#create")
    end

    it "routes to #update" do
      put("/administradors/1").should route_to("administradors#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/administradors/1").should route_to("administradors#destroy", :id => "1")
    end

  end
end
