class RedexporterAdminMenuHooks < Redmine::Hook::ViewListener
  def view_layouts_base_html_head(context = {})
    stylesheet_link_tag('redexporter.css', :plugin => 'redexporter')
  end
end