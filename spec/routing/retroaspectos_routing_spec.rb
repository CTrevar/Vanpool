require "spec_helper"

describe RetroaspectosController do
  describe "routing" do

    it "routes to #index" do
      get("/retroaspectos").should route_to("retroaspectos#index")
    end

    it "routes to #new" do
      get("/retroaspectos/new").should route_to("retroaspectos#new")
    end

    it "routes to #show" do
      get("/retroaspectos/1").should route_to("retroaspectos#show", :id => "1")
    end

    it "routes to #edit" do
      get("/retroaspectos/1/edit").should route_to("retroaspectos#edit", :id => "1")
    end

    it "routes to #create" do
      post("/retroaspectos").should route_to("retroaspectos#create")
    end

    it "routes to #update" do
      put("/retroaspectos/1").should route_to("retroaspectos#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/retroaspectos/1").should route_to("retroaspectos#destroy", :id => "1")
    end

  end
end
