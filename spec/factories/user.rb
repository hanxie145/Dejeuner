FactoryGirl.define do
  factory :user do
    name 'Tony Xie'
    email 'txie145@gmail.com'
    password 'changeme145'
    password_confirmation 'changeme145'
    restaurant "Tony's Tonics"
    sms_credit 500 
    sms_sent 0
    # required if the Devise Confirmable module is used
    # confirmed_at Time.now
  end
end