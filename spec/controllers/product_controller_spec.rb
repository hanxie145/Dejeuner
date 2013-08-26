require 'spec_helper'

describe ProductController do 
  before {@user = User.new(name: "Tony Xie", email: "testtest@gmail.com",restaurant: "Tony's Tonics", password: "foobar145", password_confirmation: "foobar145")}

  describe 'GET #main page' do 
    # before { controller.stub(:authenticate_user!).and_return true } 

    # it "successfully responds with HTTP 200 status code" do 
    #   # for authenticate
    #   current_user = @user
    #   get :main
    #   expect(response).to be_success
    #   expect(response.status).to eq(200)
    # end

  end



end