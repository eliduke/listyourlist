class List < ActiveRecord::Base
  belongs_to :user
  has_many :items
  has_many :comments

  scope :published, -> { where(published: true) }
end
