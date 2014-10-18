FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "foobar"
    password_confirmation "foobar"
  end

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
