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
    + RedExporter::RubyVM.ruby_process_memory_bytes \
    + RedExporter::RubyVM.ruby_threads_count \
    + RedExporter::RubyVM.ruby_gc_collections \
    + RedExporter::RubyVM.ruby_heap_allocated_pages \
    + RedExporter::RubyVM.ruby_heap_available_slots \
    + RedExporter::RubyVM.ruby_live_objects \
    + RedExporter::ProjectsIssues.projects_count \
    + RedExporter::ProjectsIssues.issues_metrics \
    + RedExporter::ProjectsIssues.time_tracked_total \
    + RedExporter::ProjectsIssues.time_tracked_by_user \
    + RedExporter::Users.users_metrics \
    + RedExporter::System.average_request_latency \
    + RedExporter::System.max_request_latency \
    + RedExporter::System.request_count \
    + RedExporter::System.rails_cache_stats \
    + RedExporter::System.sidekiq_stats

    render plain: data
  end
end