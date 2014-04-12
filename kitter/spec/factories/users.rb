# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    username "MyString"
    name "MyString"
    email "MyString"
    background_photo_url "MyString"
    profile_photo_url "MyString"
    bio "MyString"
    website "MyString"
    verified false
    location "MyString"
    password_digest "MyString"
    country_id 1
  end
end
