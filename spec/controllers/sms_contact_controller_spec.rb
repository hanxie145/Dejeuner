require 'spec_helper'

describe SmsContactsController do
    before {@user = create(:user)}
    before {sign_in @user}

    describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index
      response.should be_success
    end
  end

end
