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

  describe "GET 'delete'" do
    it "returns http success" do
      get 'delete'
      response.should be_success
    end
  end

end
