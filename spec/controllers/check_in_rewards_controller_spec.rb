require 'spec_helper'

describe CheckInRewardsController do
  before {@user = create(:user)}
  before {sign_in @user}

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  describe "GET 'create'" do
    it "returns http success" do
      get 'create'
      response.should be_success
    end
  end

end
