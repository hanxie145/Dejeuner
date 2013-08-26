require 'spec_helper'

describe StaticPagesController do
  describe "GET #landing" do
    it "responds successfully with an HTTP 200 status code" do
      get :landing
      response.should be_success
    end
  end
end