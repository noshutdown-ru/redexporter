class RedexporterController < ApplicationController

  def metrics

    if Setting.plugin_redexporter['redexporter_enabled'] == 'on'
      if (params['token'] != Setting.plugin_redexporter['redexporter_prometheus_token'])
        render_error t("redexporter.settings.error.unauthorised")
        return
      end
    else
      render_error t("redexporter.settings.error.disabled")
      return
    end

    data = RedExporter::Vmstat.load_average_one_minute \
    + RedExporter::Vmstat.disk_total_bytes \
    + RedExporter::Vmstat.disk_used_bytes \
    + RedExporter::Vmstat.disk_free_bytes \
    + RedExporter::Vmstat.cpu_usage \
    + RedExporter::Redmine.redmine_files_bytes \
    + RedExporter::Redmine.sessions_count \
    + RedExporter::Redmine.user_count \
    + RedExporter::Redmine.redmine_all_issues_count \
    + RedExporter::Redmine.redmine_closed_issues_count

    render plain: data
  end
end