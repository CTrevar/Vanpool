require "spec_helper"

describe ReservacionsController do
  describe "routing" do

    it "routes to #index" do
      get("/reservacions").should route_to("reservacions#index")
    end

    it "routes to #new" do
      get("/reservacions/new").should route_to("reservacions#new")
    end

    it "routes to #show" do
      get("/reservacions/1").should route_to("reservacions#show", :id => "1")
    end

    it "routes to #edit" do
      get("/reservacions/1/edit").should route_to("reservacions#edit", :id => "1")
    end

    it "routes to #create" do
      post("/reservacions").should route_to("reservacions#create")
    end

    it "routes to #update" do
      put("/reservacions/1").should route_to("reservacions#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/reservacions/1").should route_to("reservacions#destroy", :id => "1")
    end

  end
end
