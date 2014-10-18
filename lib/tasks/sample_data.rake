namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    ActiveRecord::Base.transaction do
      make_users(10)
      make_articles(10)
    end
  end
end

def make_users(num)
  puts "make users"
  num.times do |n|
    name  = Faker::Name.name
    email = "example-#{n}@example.com"
    password  = "foobar"
    User.create!(name: name,
                 email: email,
                 password: password,
                 password_confirmation: password)
  end
end

def make_articles(num)
  puts "make articles"
  num.times do |n|
    article = Article.create!(title: "Title-#{n}-0", content: Faker::Lorem.paragraph(5))
    2.times do |m|
      article.update_attributes!(title: "Title-#{n}-#{m+1}", content: Faker::Lorem.paragraph(5))
    end
  end
end
