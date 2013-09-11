require "spec_helper"

describe SignupEmailsController do
  describe "routing" do

    it "routes to #index" do
      get("/signup_emails").should route_to("signup_emails#index")
    end

    it "routes to #new" do
      get("/signup_emails/new").should route_to("signup_emails#new")
    end

    it "routes to #show" do
      get("/signup_emails/1").should route_to("signup_emails#show", :id => "1")
    end

    it "routes to #edit" do
      get("/signup_emails/1/edit").should route_to("signup_emails#edit", :id => "1")
    end

    it "routes to #create" do
      post("/signup_emails").should route_to("signup_emails#create")
    end

    it "routes to #update" do
      put("/signup_emails/1").should route_to("signup_emails#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/signup_emails/1").should route_to("signup_emails#destroy", :id => "1")
    end

  end
end
