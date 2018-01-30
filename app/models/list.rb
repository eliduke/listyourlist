class List < ActiveRecord::Base
  # 'public' and 'private' are reserved words
  enum status: [:publik, :secret, :priv8]

  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :items, inverse_of: :list, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_secure_token :secret_id

  has_permalink

  accepts_nested_attributes_for :items,
    reject_if: proc { |params| params['body'].blank? },
    allow_destroy: true

  validates :title, presence: true
  validates :user_id, presence: true

  validates_associated :items
  validates_associated :comments

  def secret_link
    (persisted? && secret?) ? "https://listyourlist.com/lists/#{secret_id}" : nil
  end
end
