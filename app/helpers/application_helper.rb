module ApplicationHelper
  include Pagy::Frontend

  def display_errors(object)
    return unless object.errors.any?

    content_tag(:div, class: 'alert alert-danger') do
      concat content_tag(:h4, pluralize(object.errors.count, "error") + " prohibited this #{object.class.name.downcase} from being saved:")
      concat content_tag(:ul) do
        object.errors.full_messages.each do |message|
          concat content_tag(:li, message)
        end
      end
    end
  end
end
