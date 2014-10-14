namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_articles(10)
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
