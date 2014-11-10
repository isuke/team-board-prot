namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    ActiveRecord::Base.transaction do

      make_users(10)
      make_teams(3)

      Team.all.each do |team|
        users = User.all.sample(5)
        make_team_users(team, users)
        10.times do |n|
          article = make_article(team, users.shuffle[0..3], "#{team.name}-#{n}")
          rand(10).times do
            make_comment(article, users.sample)
          end
        end
      end

    end
  end
end

def make_team
  name = Faker::Name.name
  Team.create!(name: name)
end

def make_teams(num)
  num.times do |n|
    make_team
  end
end

def make_user(email: Faker::Internet.email)
  name  = Faker::Name.name
  password  = "foobar"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password)
end

def make_users(num)
  num.times do |n|
    make_user(email: "example-#{n}@example.com")
  end
end

def make_team_user(team=nil, user=nil, role: :usual)
  team = team || Team.first || make_team
  user = user || User.first || make_user
  teams_user = team.add_member(user, role: role)
  teams_user.save!
  teams_user
end

def make_team_users(team=nil, users=[])
  team = team || Team.first || make_team
  first = true
  users.each do |user|
    if first
      first = false
      make_team_user(team, user, role: :admin)
    else
      make_team_user(team, user, role: :usual)
    end
  end
end

def make_article(team, users, title="Title")
  article = Article.create!(title: "#{title}-0",
                            content: Faker::Lorem.paragraph(5),
                            team: team,
                            user: users.delete_at(0))
  users.each_with_index do |user, m|
    article.update_attributes!(title: "#{title}-#{m+1}",
                               content: Faker::Lorem.paragraph(5),
                               team: team,
                               user: user)
  end
  article
end

def make_comment(article, user)
  comment = article.comments.build(user_id: user.id, content: Faker::Lorem.sentence)
  comment.save!
  comment
end
