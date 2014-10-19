class User < ActiveRecord::Base
  validates :name, presence: true,
            length: { maximum: 50 }
  validates :email, presence: true,
            format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i },
            uniqueness: true
  validates :password, length: { minimum: 6 }

  has_secure_password

  # has_many :articles # can not write this, because a article have not user_id.
  has_many :article_logs, dependent: :nullify
  has_many :comments    , dependent: :nullify

  before_save { email.downcase! }
  before_create :create_remember_token

  def self.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def self.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def null_user?
    false
  end

  private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end

end

