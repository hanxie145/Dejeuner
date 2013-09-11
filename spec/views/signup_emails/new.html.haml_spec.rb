require 'spec_helper'

describe "signup_emails/new" do
  before(:each) do
    assign(:signup_email, stub_model(SignupEmail,
      :email => "MyString",
      :description => "MyText"
    ).as_new_record)
  end

  it "renders new signup_email form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => signup_emails_path, :method => "post" do
      assert_select "input#signup_email_email", :name => "signup_email[email]"
      assert_select "textarea#signup_email_description", :name => "signup_email[description]"
    end
  end
end
