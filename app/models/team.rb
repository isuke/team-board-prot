class Team < ActiveRecord::Base
  has_many :teams_users, dependent: :destroy
  has_many :users, through: :teams_users
  has_many :articles, dependent: :destroy

  validates :name, presence: true
end
