FactoryGirl.define do

  factory :article do
    after(:create) do |article|
      3.times { create(:article_log, article: article) }
    end
  end

  factory :article_log do
    article
    sequence(:title) { |n| "Title-#{n}" }
    content "Lorem ipsum"
  end
end
