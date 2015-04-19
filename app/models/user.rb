class User < ActiveRecord::Base
  has_many :lists
  has_many :comments
  has_many :likes

  validates_associated :lists
  validates_associated :comments

  # :confirmable, :lockable, :timeoutable and :omniauthable
  # devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
end
