module ApplicationHelper
  def link_to_user(user)
    link_to user.login, profile_path(user.login)
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

  def error_messages_for(object, attribute, alignment="right")
    messages = if attribute == :items
      object.errors.messages[attribute].join(", ")
    else
      object.errors.full_messages_for(attribute).join(", ")
    end

    if object.errors.messages[attribute].present?
      "<p class='error_messages_for pink text-#{alignment}'>#{messages}</p>".html_safe
    end
  end
end
