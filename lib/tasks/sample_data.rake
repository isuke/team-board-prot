namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    ActiveRecord::Base.transaction do
      users = []
      teams = []

      make_users(10) do |user|
        users << user
      end

      make_teams(2) do |team|
        teams << team
      end

      make_teams_users(teams, users)

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
    user = User.create!(name: name,
                        email: email,
                        password: password,
                       password_confirmation: password)
    yield user
  end
end

def make_teams(num)
  puts "make teams"
  num.tims do |n|
    name = Faker::Name.name
    team = Team.create!(name: name)
    yield team
  end
end

def make_teams_users(teams, users)
  teams.each do |team|
    users.each do |user|
      user.participate team
    end
  end
end

def make_articles(num)
  puts "make articles"
  first_user  = User.first
  second_user = User.second
  num.times do |n|
    article = Article.create!(title: "Title-#{n}-0", content: Faker::Lorem.paragraph(5), user: first_user)
    2.times do |m|
      article.update_attributes!(title: "Title-#{n}-#{m+1}", content: Faker::Lorem.paragraph(5), user: second_user)
    end
  end
end
