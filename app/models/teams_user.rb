class TeamsUser < ActiveRecord::Base
  belongs_to :team
  belongs_to :user

  validates :team_id, presence: true,
                      uniqueness: { scope: :user_id }
  validates :user_id, presence: true

  enum role: { admin: 10, usual: 30, guest: 50 }
end
