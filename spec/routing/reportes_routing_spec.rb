require "spec_helper"

describe ReportesController do
  describe "routing" do

    it "routes to #index" do
      get("/reportes").should route_to("reportes#index")
    end

    it "routes to #new" do
      get("/reportes/new").should route_to("reportes#new")
    end

    it "routes to #show" do
      get("/reportes/1").should route_to("reportes#show", :id => "1")
    end

    it "routes to #edit" do
      get("/reportes/1/edit").should route_to("reportes#edit", :id => "1")
    end

    it "routes to #create" do
      post("/reportes").should route_to("reportes#create")
    end

    it "routes to #update" do
      put("/reportes/1").should route_to("reportes#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/reportes/1").should route_to("reportes#destroy", :id => "1")
    end

  end
end
