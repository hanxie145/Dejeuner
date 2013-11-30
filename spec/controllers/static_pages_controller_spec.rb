require 'spec_helper'

describe StaticPagesController do
  describe "GET #landing" do
    it "responds successfully with an HTTP 200 status code" do
      get :landing
      response.should be_success
    end
  end

  describe "GET #about" do
    it "responds successfully with an HTTP 200 status code" do
      get :about
      response.should be_success
    end
  end

  describe "GET #pricing" do
    it "responds successfully with an HTTP 200 status code" do
      get :pricing
      response.should be_success
    end
  end
end