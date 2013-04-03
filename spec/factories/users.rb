FactoryGirl.define do
  factory :user do
    name "testuser"
    blog_name "Test User"
    description "Test User description"
    photo "http://example.com/photo.png"
  end
end
