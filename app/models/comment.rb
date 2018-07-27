class Comment < ActiveRecord::Base
  belongs_to :list
  belongs_to :user

  def editable?
    Time.now.to_i - created_at.to_i < 3600
  end

  def more_than_one_week_old?
    Time.now.to_i - created_at.to_i > 604800
  end
end
