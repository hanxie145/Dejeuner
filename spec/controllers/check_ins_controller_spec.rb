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

  describe 'check in process' do 
    it 'checks in correctly' do 
      SmsContact.should_receive :create
      post 'create', number: "6049108862"
    end 
  end

end
