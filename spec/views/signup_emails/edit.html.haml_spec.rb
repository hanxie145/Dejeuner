require 'spec_helper'

describe "signup_emails/edit" do
  before(:each) do
    @signup_email = assign(:signup_email, stub_model(SignupEmail,
      :email => "MyString",
      :description => "MyText"
    ))
  end

  it "renders the edit signup_email form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => signup_emails_path(@signup_email), :method => "post" do
      assert_select "input#signup_email_email", :name => "signup_email[email]"
      assert_select "textarea#signup_email_description", :name => "signup_email[description]"
    end
  end
end
