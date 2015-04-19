class Item < ActiveRecord::Base
  belongs_to :list
  default_scope { order(:position) }

  validates :body, presence: true
  validates :body, length: { maximum: 255 }

end
