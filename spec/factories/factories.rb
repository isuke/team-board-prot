FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "foobar"
    password_confirmation "foobar"
  end

  factory :article do
    user
    team
    sequence(:title) { |n| "Title-#{n}" }
    content "Lorem ipsum"

    after(:create) do |article|
      original_title = article.title
      2.times do |i|
        article.update_attributes!(title: "#{original_title}-#{i}",
                                   content: "Lorem ipsum #{i}")
      end
      2.times do |i|
        create(:comment, article: article, user: create(:user))
      end
    end
  end

  factory :comment do
    article
    user
    content "Lorem ipsum"
  end

  factory :team do
    sequence(:name) { |n| "Team-#{n}" }

    after(:create) do |team|
      2.times do |i|
        create(:teams_user, team: team, user: create(:user))
      end
    end
  end

  factory :teams_user do
    team
    user
  end
end
