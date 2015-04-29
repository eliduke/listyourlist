class Comment < ActiveRecord::Base
  belongs_to :list
  belongs_to :user

  default_scope { where(deleted: false) }
end
