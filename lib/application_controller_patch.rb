module ApplicationControllerPatch
  def self.included(base) # :nodoc:
    # Same as typing in the class
    base.class_eval do
      around_action :collect_metrics

      def collect_metrics
        start = Time.now
        yield
        duration = Time.now - start
        Rails.logger.info({ controller: controller_name, action: action_name, duration: duration }.to_json)
      end
    end
  end
end