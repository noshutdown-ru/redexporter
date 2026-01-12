class RedexporterSettingsController < ApplicationController
  menu_item :redexporter_settings

  layout 'admin'
  before_action :require_admin

  def index

  end

  def save
    Setting.send "plugin_redexporter=", params[:settings]
    redirect_to '/redexporter_settings', notice: t('notice.settings.saved')
  end
end