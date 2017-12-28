class User < ActiveRecord::Base
  has_many :lists
  has_many :comments
  has_many :likes

  has_secure_password

  validates :username, :email, presence: true

  validates_associated :lists
  validates_associated :comments

  default_scope { where(deleted: false) }

  def can_see(list)
    lists.include?(list)
  end

end
