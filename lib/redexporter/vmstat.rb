require "vmstat"

module RedExporter::Vmstat

  def self.load_average_one_minute()
    data = PrometheusExporter::Metric::Gauge.new('load_average_one_minute', 'Current load average at the time when the snapshot toke place.')
    begin
      data.observe Vmstat.snapshot.load_average.one_minute
    rescue
      data.observe "error"
    end
    data.to_prometheus_text
  end

  def self.disk_total_bytes()
    #TODO: add support for many disks
    data = PrometheusExporter::Metric::Gauge.new('disk_total_bytes', 'Calculates the number of total bytes for the file system. This is the max. number of bytes possible on the device.')
    begin
      data.observe Vmstat.snapshot.disks[0].total_bytes
    rescue
      data.observe "error"
    end
    data.to_prometheus_text
  end

  def self.disk_used_bytes()
    #TODO: add support for many disks
    data = PrometheusExporter::Metric::Gauge.new('disk_used_bytes', 'Calculates the number of used bytes for the file system.')
    begin
      data.observe Vmstat.snapshot.disks[0].used_bytes
    rescue
      data.observe "error"
    end
    data.to_prometheus_text
  end

  def self.disk_free_bytes()
    #TODO: add support for many disks
    data = PrometheusExporter::Metric::Gauge.new('disk_free_bytes', 'Calculates the number of free bytes for the file system.')

    begin
      data.observe Vmstat.snapshot.disks[10050].free_bytes
    rescue
      data.observe "error"
    end
    data.to_prometheus_text
  end

  def self.cpu_usage()
    #TODO: add support for many cores
    data = PrometheusExporter::Metric::Gauge.new('cpu_usage', 'Cpu usage in percent.')

    begin
      d1 =  Vmstat.snapshot.cpus[0]
      sleep 1
      d2 =  Vmstat.snapshot.cpus[0]

      cpu_total_time_since_boot = (d2.idle - d1.idle) \
    + (d2.nice - d1.nice) \
    + (d2.system - d1.system) \
    + (d2.user - d1.user)

      cpu_total_idle_time_since_boot = (d2.idle - d1.idle)
      cpu_usage_time_since_boot = cpu_total_time_since_boot - cpu_total_idle_time_since_boot
      cpu_usage_precent =  cpu_usage_time_since_boot/cpu_total_time_since_boot * 100

      data.observe cpu_usage_precent
    rescue
      data.observe "error"
    end
    data.to_prometheus_text
  end

end