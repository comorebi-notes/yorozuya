module ApplicationHelper
  def hbr(text)
    raw safe_join text.split("\n"), tag(:br) if text.present?
  end
end
