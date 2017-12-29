module ListsHelper
  def link_to_user(user)
    link_to user.username, profile_path(user.username)
  end

  def editable_by_current_user?(list, current_user)
    current_user.lists.include?(list) if current_user
  end

  def listed_by(list, current_user)
    if editable_by_current_user?(@list, current_user)
      "Listed by <strong>YOU</strong> on #{@list.created_at.strftime("%B #{@list.created_at.day.ordinalize}, %Y")} :"
    else
      "Listed by #{link_to_user(@list.user)} on #{@list.created_at.strftime("%B #{@list.created_at.day.ordinalize}, %Y")}"
    end
  end
end
