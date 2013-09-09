require 'spec_helper'

describe ProductController do 

  # sign in user and by pass authentication
  before {@user = create(:user)}
  before { controller.stub(:authenticate_user!).and_return true } 
  before {sign_in @user}

  describe 'GET #main page' do 

    it "#main should be valid" do 
      get :main
      response.should be_success
    end

  end

  describe 'GET #profile' do

    it "#profile should be valid" do 
      get :profile 
      response.should be_success
    end
    
  end

end