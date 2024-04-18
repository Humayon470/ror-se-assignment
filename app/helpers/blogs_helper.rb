module BlogsHelper
  def display_errors_for(object)
    return unless object.errors.any?

    content_tag(:div, class: 'text-danger') do
      concat content_tag(:h2, pluralize(object.errors.count, "error") + " prohibited this #{object.class.model_name.human.downcase} from being saved:")
      object.errors.full_messages.each do |message|
        concat content_tag(:h5, message)
      end
    end
  end
end
