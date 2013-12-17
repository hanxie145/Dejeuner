require 'spec_helper'

describe CheckInsController do
  before {@user = create(:user)}
  before {sign_in @user}

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
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
