class User < ActiveRecord::Base
  attr_accessor :remember_token

  has_many :lists, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_secure_password

  validates :username,
    presence: true,
    format: {
      with: /\A[\w\.]+\z/,
      message: "only allows letters, numbers, underscores, and periods"
    }

  validates :email,
    presence: true,
    format: { with: /[\S]+\@[\S]+\.[\S]+/ }

  validates :url,
    format: {
      with: /\A(http|https):\/\/[\S]+\.[\S]+\z/,
      message: "is invalid. Make sure you include 'http://' or 'https://' at the beginning.",
      allow_blank: true
    }

  validates_associated :lists
  validates_associated :comments

  def owns?(list)
    list.in?(lists)
  end

  ### AUTHENTICATION STUFF, KEEP AT BOTTOM ###

  class << self
    def new_token
      SecureRandom.urlsafe_base64
    end

    def digest(string)
      cost = if ActiveModel::SecurePassword.min_cost
        BCrypt::Engine::MIN_COST
      else
        BCrypt::Engine.cost
      end

      BCrypt::Password.create(string, cost: cost)
    end
  end

  def remember!
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def forget!
    update_attribute(:remember_digest, nil)
  end

  def authenticated?(remember_token)
    if remember_digest && remember_token
      BCrypt::Password.new(remember_digest).is_password?(remember_token)
    else
      return false
    end
  end
end
