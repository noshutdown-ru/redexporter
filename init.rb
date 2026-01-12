require_dependency "#{Rails.root}/plugins/redexporter/lib/redexporter_admin_menu_hooks"
require_dependency "#{Rails.root}/plugins/redexporter/lib/redexporter/redexporter"
require_dependency "#{Rails.root}/plugins/redexporter/lib/redexporter/vmstat"
require_dependency "#{Rails.root}/plugins/redexporter/lib/redexporter/redmine"
require_dependency "#{Rails.root}/plugins/redexporter/lib/application_controller_patch"

ApplicationController.include ApplicationControllerPatch

Redmine::Plugin.register :redexporter do
  name 'Redexporter plugin'
  author 'noshutdown.ru'
  description 'Allows you expose Redmine metrics to Prometheus'
  version '1.0.0'
  url 'https://github.com/noshutdown-ru/redexporter'
  author_url 'https://noshutdown.ru/'

  settings :default => {'empty' => true}, :partial => 'settings/redexporter_settings'

  menu :admin_menu, :redexporter, {
          :controller => 'redexporter_settings',
          :action => 'index'
       },
       :caption => :redexporter_label,
       :html => {:class => 'icon'}

end