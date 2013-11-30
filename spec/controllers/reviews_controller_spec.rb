require 'spec_helper'

describe ReviewsController do
  before {@user = create(:user)}
  before {sign_in @user}

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

end
