class Item < ActiveRecord::Base
  belongs_to :list, inverse_of: :items

  default_scope { order(:position) }

  validates :body, presence: true
  validates :body, length: { maximum: 500 }
end
