class List < ActiveRecord::Base
  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :items, inverse_of: :list, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_secure_token :secure_id

  has_permalink

  accepts_nested_attributes_for :items,
    reject_if: proc { |params| params['body'].blank? },
    allow_destroy: true

  validates :title, presence: true
  validates :user_id, presence: true

  validates_associated :items
  validates_associated :comments

  ######## DEFAULT SCOPE ########
  default_scope { where(deleted: false) }

  # had to name these weird because of rails reserved words
  scope :publics, ->  { where(public: true) }
  scope :privates, -> { where(public: false) }

  def private?
    !public?
  end

  def private_link
    persisted? ? "https://listyourlist.com/lists/#{secure_id}" : nil
  end
end
