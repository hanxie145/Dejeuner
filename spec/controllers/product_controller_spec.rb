require 'spec_helper'

describe ProductController do 
  before {@user = create(:user)}

  describe 'GET #main page' do 
    before { controller.stub(:authenticate_user!).and_return true } 
    before {sign_in @user}

    it "#main should be valid" do 
      get :main
      response.should be_success
    end

  end

end