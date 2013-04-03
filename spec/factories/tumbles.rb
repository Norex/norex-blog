FactoryGirl.define do
  factory :tumble do
    title "Tumble Title"
    content "Tumble Content"
    date "2013-01-01 00:00:00"
    tumblr_id 1
    url "http://example.com"
    content_type "testcontent"
    tag_list "tagtest1 tagtest2 tagtest3"
    association :user
  end
end
