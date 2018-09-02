module ApplicationControllerPatch
  def self.included(base) # :nodoc:
    # Same as typing in the class
    base.class_eval do
      unloadable # Send unloadable so it will not be unloaded in development
      around_action :collect_metrics

      def collect_metrics
        start = Time.now
        yield
        duration = Time.now - start
        print "My application_controller_patch here #{controller_name}##{action_name}: #{duration}s"
      end
    end
  end
end