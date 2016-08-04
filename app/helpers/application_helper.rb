module ApplicationHelper
  def flash_color(flash_key)
    if flash_key == :success
      return "green lighten-3"
    elsif flash_key == "error"
      return "red lighten-1"
    end
  end
end
