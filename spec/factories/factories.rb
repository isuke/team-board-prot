FactoryGirl.define do

  factory :article do
    sequence(:title) { |n| "Title-#{n}" }
    content "Lorem ipsum"

    after(:create) do |article|
      2.times do |i|
        article.update_attributes!(content: "Lorem ipsum #{i}")
      end
    end
  end
end
