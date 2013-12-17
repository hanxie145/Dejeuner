require 'spec_helper'

describe DelayedJobsController do
  before {@user = create(:user)}
  before {sign_in @user}

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'destroy'" do
    it "returns http success" do
      get 'destroy'
      response.should be_success
    end
  end

end
