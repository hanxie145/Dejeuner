require 'spec_helper'

describe ChargesController do
  before {@user = create(:user)}
  before {sign_in @user}

  describe "GET 'new' with different plan parameters" do
    it "returns http success with petite" do
      get 'new', :plan => 'petite'
      response.should be_success
    end

    it "returns http success with grande" do
      get 'new', :plan => 'grande'
      response.should be_success
    end
  end

end
