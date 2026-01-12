require "prometheus_exporter/metric"

module RedExporter::ProjectsIssues
  def self.projects_count()
    data = PrometheusExporter::Metric::Gauge.new('redmine_projects_count', 'Total number of projects')
    begin
      data.observe Project.count
    rescue
      data.observe 0
    end
    data.to_prometheus_text
  end

  def self.issues_metrics()
    result = "# HELP redmine_issues Total issues by project, type, status, and priority\n"
    result += "# TYPE redmine_issues gauge\n"

    begin
      # Group issues by project, type, status, priority
      issue_counts = Issue.all.group_by do |issue|
        {
          project: issue.project.name,
          issue_type: issue.tracker.name,
          status: issue.status.name,
          priority: issue.priority.name
        }
      end

      issue_counts.each do |labels, issues|
        count = issues.count
        label_str = "project=\"#{labels[:project]}\",issue_type=\"#{labels[:issue_type]}\",status=\"#{labels[:status]}\",priority=\"#{labels[:priority]}\""
        result += "redmine_issues{#{label_str}} #{count}\n"
      end
    rescue
      result += "redmine_issues 0\n"
    end

    result
  end

  def self.time_tracked_total()
    data = PrometheusExporter::Metric::Gauge.new('redmine_time_tracked_total_hours', 'Total hours tracked on all issues')
    begin
      total_hours = TimeEntry.sum(:hours).to_f
      data.observe total_hours
    rescue
      data.observe 0
    end
    data.to_prometheus_text
  end

  def self.time_tracked_by_user()
    result = "# HELP redmine_time_tracked_by_user_hours Hours tracked by user\n"
    result += "# TYPE redmine_time_tracked_by_user_hours gauge\n"

    begin
      # Get all users with time entries
      time_entries = TimeEntry.joins(:user).group('users.id').select('users.id, users.login, SUM(time_entries.hours) as total_hours')

      time_entries.each do |entry|
        hours = entry.total_hours.to_f
        user_login = entry.login
        result += "redmine_time_tracked_by_user_hours{user=\"#{user_login}\"} #{hours}\n"
      end
    rescue
      result += "redmine_time_tracked_by_user_hours 0\n"
    end

    result
  end

end
