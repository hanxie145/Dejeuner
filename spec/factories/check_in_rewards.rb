# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :check_in_reward do
    user_id 1
    check_in_count 1
    reward "MyString"
  end
end
