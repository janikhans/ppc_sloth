module ApplicationHelper
  def breadcrumbs_helper(breadcrumbs)
    content_tag :nav do
      content_tag :ol, class: 'breadcrumb' do
        breadcrumbs.each do |crumb|
          active = :exclusive
          active = crumb[:active] if crumb[:active] == false || crumb[:active]
          concat(active_link_to(crumb[:text], crumb[:path], wrap_tag: :li, wrap_class: 'breadcrumb-item', active: active))
        end
      end
    end
  end

  def sidebar_nav_item(path, text, icon, options = {})
    active_link_to path, wrap_tag: :li, wrap_class: 'nav-item', class: "nav-link #{options[:class]}", active: options[:active], data: options[:data] do
      concat(icon(:fas, icon, class: "fa-fw mr-1 #{options[:class]}"))
      concat(content_tag(:span, text))
    end
  end

  def asin_link(asin)
    link = "https://www.amazon.com/dp/#{asin}"
    link_to link, link, target: :_blank
  end
end
