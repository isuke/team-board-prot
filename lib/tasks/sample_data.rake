namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_articles(10)
  end
end

def make_articles(num)
  puts "make articles"
  num.times do |n|
    article = Article.create
    make_article_logs(article, 3)
  end
end

def make_article_logs(article, num)
  num.times do |n|
    title = "Title-#{article.id}-#{n}"
    content = Faker::Lorem.paragraph(5)
    article.logs.create(title: title, content: content)
  end
end
