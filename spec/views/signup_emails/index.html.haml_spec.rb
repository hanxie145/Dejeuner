require 'spec_helper'

describe "signup_emails/index" do
  before(:each) do
    assign(:signup_emails, [
      stub_model(SignupEmail,
        :email => "Email",
        :description => "MyText"
      ),
      stub_model(SignupEmail,
        :email => "Email",
        :description => "MyText"
      )
    ])
  end

  it "renders a list of signup_emails" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
