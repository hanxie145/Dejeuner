require 'spec_helper'

describe ProductController do 

  # sign in user and by pass authentication
  before {@user = create(:user)}
  before {sign_in @user}

  describe '#main page' do 
    it "GET #main should be valid" do 
      get :main
      response.should be_success
    end
  end

  describe '#profile' do
    it "GET #profile should be valid" do 
      get :profile 
      response.should be_success
    end
  end

  describe '#market' do 
    it 'GET should respond with 200 to new users' do 
      get :market 
      response.should be_success
    end
  end
  
end