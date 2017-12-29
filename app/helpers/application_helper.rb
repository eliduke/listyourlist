module ApplicationHelper
  def error_messages_for(object, attribute, alignment="right")
    messages = if attribute == :items
      object.errors.messages[attribute].join(", ")
    else
      object.errors.full_messages_for(attribute).join(", ")
    end

    if object.errors.messages[attribute].present?
      "<p class='error-messages-for text-#{alignment}'>#{messages}</p>".html_safe
    end
  end
end
