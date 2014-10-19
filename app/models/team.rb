class Team < ActiveRecord::Base
  has_many :teams_users, dependent: :destroy
  has_many :users, through: :teams_users

  validates :name, presence: true
end
