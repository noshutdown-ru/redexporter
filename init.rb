require 'redexporter_admin_menu_hooks'
#require 'application_controller_patch'

require 'redexporter/redexporter'
require 'redexporter/vmstat'
require 'redexporter/redmine'

#Rails.configuration.to_prepare do
#  ApplicationController.send(:include, ApplicationControllerPatch) unless Issue.included_modules.include? ApplicationControllerPatch
#end

Redmine::Plugin.register :redexporter do
  name 'Redexporter plugin'
  author 'noshutdown.ru'
  description 'Allows you expose Redmine metrics to Prometheus'
  version '0.0.2'
  url 'https://noshutdown.ru/redmine-plugins-redexporter/'
  author_url 'https://noshutdown.ru/'

  settings :default => {'empty' => true}, :partial => 'settings/redexporter_settings'

  menu :admin_menu, :redexporter, {
          :controller => 'redexporter_settings',
          :action => 'index'
       },
       :caption => :redexporter_label,
       :html => {:class => 'icon'}

end