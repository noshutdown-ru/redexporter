require "prometheus_exporter/metric"

module RedExporter::RubyVM
  def self.ruby_process_memory_bytes()
    data = PrometheusExporter::Metric::Gauge.new('ruby_process_memory_bytes', 'Process memory usage in bytes (RSS)')
    begin
      rss = `ps -o rss= -p #{Process.pid}`.to_i * 1024
      data.observe rss
    rescue
      data.observe 0
    end
    data.to_prometheus_text
  end

  def self.ruby_threads_count()
    data = PrometheusExporter::Metric::Gauge.new('ruby_threads_count', 'Number of Ruby threads')
    begin
      data.observe Thread.list.count
    rescue
      data.observe 0
    end
    data.to_prometheus_text
  end

  def self.ruby_gc_collections()
    data = PrometheusExporter::Metric::Gauge.new('ruby_gc_collections', 'Total GC collections')
    begin
      gc_stats = GC.stat
      data.observe gc_stats[:count]
    rescue
      data.observe 0
    end
    data.to_prometheus_text
  end

  def self.ruby_heap_allocated_pages()
    data = PrometheusExporter::Metric::Gauge.new('ruby_heap_allocated_pages', 'Number of allocated heap pages')
    begin
      gc_stats = GC.stat
      data.observe gc_stats[:heap_allocated_pages]
    rescue
      data.observe 0
    end
    data.to_prometheus_text
  end

  def self.ruby_heap_available_slots()
    data = PrometheusExporter::Metric::Gauge.new('ruby_heap_available_slots', 'Number of available heap slots')
    begin
      gc_stats = GC.stat
      data.observe gc_stats[:heap_available_slots]
    rescue
      data.observe 0
    end
    data.to_prometheus_text
  end

  def self.ruby_live_objects()
    data = PrometheusExporter::Metric::Gauge.new('ruby_live_objects', 'Number of live objects')
    begin
      gc_stats = GC.stat
      data.observe gc_stats[:total_allocated_objects] - gc_stats[:total_freed_objects]
    rescue
      data.observe 0
    end
    data.to_prometheus_text
  end
end
