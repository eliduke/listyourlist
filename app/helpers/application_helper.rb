module ApplicationHelper
  def error_messages_for(object, attribute, alignment="right")
    messages = if attribute == :items
      object.errors.messages[attribute].join(", ")
    else
      object.errors.full_messages_for(attribute).join(", ")
    end

    if object.errors.messages[attribute].present?
      content_tag :p, messages, class: "error-messages-for text-#{alignment}"
    end
  end

  def strikethrough_heading(text:)
    content_tag :div, class: "strikethrough" do
      tag(:hr) + content_tag(:h4, text)
    end
  end

  def display_none_if(boolean)
    "style=display:none" if boolean
  end

  def display_if(boolean)
    "style=display:none" unless boolean
  end
end
