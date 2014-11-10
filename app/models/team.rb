class Team < ActiveRecord::Base
  has_many :teams_users, dependent: :destroy
  has_many :users, through: :teams_users
  has_many :articles, dependent: :destroy

  validates :name, presence: true


  def add_member(user, role: :usual)
    teams_users.build(user_id: user.id, role: role)
  end

  def remove_member(user)
    TeamsUser.find_by(team_id: self.id,
                      user_id: user.id).destroy
  end

  def member?(user)
    users.include? user
  end
end
