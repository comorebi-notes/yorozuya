module Admin::ApplicationHelper
  def nav_menu_classname(path)
    request.path.include?(path) ? 'active' : ''
  end
end
