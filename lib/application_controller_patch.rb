module ApplicationControllerPatch
  def self.included(base) # :nodoc:
    # Same as typing in the class
    base.class_eval do
      around_action :collect_metrics, except: :metrics

      def collect_metrics
        start = Time.now
        yield
        duration = Time.now - start
        RedExporter::System.record_request_latency(duration)
        Rails.logger.info({ controller: controller_name, action: action_name, duration: duration }.to_json)
      end
    end
  end
end