FactoryGirl.define do
  factory :user do
    name 'Tony Xie'
    email 'txie145@gmail.com'
    password 'changeme145'
    password_confirmation 'changeme145'
    restaurant "Tony's Tonics"
    # required if the Devise Confirmable module is used
    # confirmed_at Time.now
  end
end