module ApplicationHelper
  def field_has_error?(model, field)
    model&.errors&.keys&.include?(field) ? 'field-has-errors' : ''
  end
end
