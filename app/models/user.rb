class User < ActiveRecord::Base
  has_many :lists
  has_many :comments
  has_many :likes

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

  default_scope { where(deleted: false) }

  def can_see(list)
    lists.include?(list)
  end

end
