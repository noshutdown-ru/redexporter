
module RedExporter::Redmine
  def self.sessions_count()
    data = PrometheusExporter::Metric::Gauge.new('redmine_sessions_count', 'Number of sessions in the Redmine')
    # -1 becouse it is anonymous
    begin
      data.observe User.where("last_login_on < ?", 5.seconds.ago).count - 1
    rescue
      data.observe 0
    end
    data.to_prometheus_text
  end

  def self.redmine_files_bytes()
    data = PrometheusExporter::Metric::Gauge.new('redmine_files_bytes', 'How much bytes redmine/files folder consume')
    begin
      size=0
      Dir.glob(File.join("#{Rails.root}/files", '**', '*')) { |file| size+=File.size(file) }
      data.observe size
    rescue
      data.observe 0
    end
    data.to_prometheus_text
  end

end


