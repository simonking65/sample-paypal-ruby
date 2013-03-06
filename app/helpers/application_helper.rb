module ApplicationHelper
  def active_li(name, path, *args)
    content_tag "li", :class => ( request.path == path ? "active" : "" ) do
      link_to name, path, *args
    end
  end

  def current_year
    @current_year ||= Time.now.year
  end
end
