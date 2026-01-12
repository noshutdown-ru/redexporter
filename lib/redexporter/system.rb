require "prometheus_exporter/metric"

module RedExporter::System
  @@request_latencies = []
  @@db_queries = 0
  @@cache_hits = 0
  @@cache_misses = 0

  def self.reset_metrics
    @@request_latencies = []
    @@db_queries = 0
    @@cache_hits = 0
    @@cache_misses = 0
  end

  def self.record_request_latency(duration)
    @@request_latencies << duration
    # Keep only last 100 requests
    @@request_latencies = @@request_latencies.last(100)
  end

  def self.average_request_latency()
    data = PrometheusExporter::Metric::Gauge.new('redmine_average_request_latency_seconds', 'Average request latency in seconds')
    begin
      if @@request_latencies.any?
        avg = @@request_latencies.sum / @@request_latencies.length.to_f
        data.observe avg
      else
        data.observe 0
      end
    rescue
      data.observe 0
    end
    data.to_prometheus_text
  end

  def self.max_request_latency()
    data = PrometheusExporter::Metric::Gauge.new('redmine_max_request_latency_seconds', 'Maximum request latency in seconds')
    begin
      if @@request_latencies.any?
        data.observe @@request_latencies.max
      else
        data.observe 0
      end
    rescue
      data.observe 0
    end
    data.to_prometheus_text
  end

  def self.request_count()
    data = PrometheusExporter::Metric::Gauge.new('redmine_request_count', 'Total number of requests processed')
    begin
      data.observe @@request_latencies.length
    rescue
      data.observe 0
    end
    data.to_prometheus_text
  end

  def self.rails_cache_stats()
    result = ""
    begin
      # Get cache store stats if available
      cache = Rails.cache
      if cache.respond_to?(:stats)
        stats = cache.stats

        hits = PrometheusExporter::Metric::Gauge.new('redmine_cache_hits', 'Number of cache hits')
        hits.observe(stats[:hits] || 0)
        result += hits.to_prometheus_text

        misses = PrometheusExporter::Metric::Gauge.new('redmine_cache_misses', 'Number of cache misses')
        misses.observe(stats[:misses] || 0)
        result += misses.to_prometheus_text
      end
    rescue
    end
    result
  end

  def self.sidekiq_stats()
    result = ""
    begin
      if defined?(Sidekiq)
        stats = Sidekiq::Stats.new

        processed = PrometheusExporter::Metric::Gauge.new('sidekiq_processed', 'Total jobs processed')
        processed.observe stats.processed
        result += processed.to_prometheus_text

        failed = PrometheusExporter::Metric::Gauge.new('sidekiq_failed', 'Total failed jobs')
        failed.observe stats.failed
        result += failed.to_prometheus_text

        queued = PrometheusExporter::Metric::Gauge.new('sidekiq_queue_size', 'Jobs in queue')
        queued.observe stats.processes_size
        result += queued.to_prometheus_text
      end
    rescue
      # Sidekiq not installed
    end
    result
  end
end
