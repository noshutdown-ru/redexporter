require 'prometheus_exporter/metric'

module RedExporter
  #TODO: store data in database for decrease load on system
  # gauge = PrometheusExporter::Metric::Gauge.new("rss", "used RSS for process")
  # counter = PrometheusExporter::Metric::Counter.new("web_requests", "number of web requests")
  # summary = PrometheusExporter::Metric::Summary.new("page_load_time", "time it took to load page")
  #
  # gauge.observe(1)
  # gauge.observe(2)
  #
  # counter.observe(1, route: 'test/route')
  # counter.observe(1, route: '/')
  #
  # summary.observe(1.1)
  # summary.observe(1.12)
  # summary.observe(0.12)
end