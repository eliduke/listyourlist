class List < ActiveRecord::Base
  belongs_to :user
  has_many :items
  has_many :comments
  has_many :likes

  validates :title, presence: true
  validates :user_id, presence: true

  validates_associated :items
  validates_associated :comments

  default_scope { where(deleted: false).where(published: true) }

  def to_param
    "#{id}-#{title.parameterize}"
  end
end
