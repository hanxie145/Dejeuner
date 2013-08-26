require 'spec_helper'

describe StaticPagesController do
  describe "GET #landing" do
    it "responds successfully with an HTTP 200 status code" do
      get :landing
      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it "renders the index template" do
      get :landing
      expect(response).to render_template("landing")
    end

  end
end