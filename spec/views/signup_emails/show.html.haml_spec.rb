require 'spec_helper'

describe "signup_emails/show" do
  before(:each) do
    @signup_email = assign(:signup_email, stub_model(SignupEmail,
      :email => "Email",
      :description => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Email/)
    rendered.should match(/MyText/)
  end
end
