module ActivityEngine
  class ActivitySweeper < ActionController::Caching::Sweeper
    class << self
      def observe(*models)
        models.flatten!
        models.collect! { |model| model.respond_to?(:to_sym) ? model.to_s.camelize.constantize : model }
        models.each {|model|
          model.send(:include, ActiveModel::Observing) unless model.included_modules.include?(ActiveModel::Observing)
        }
        models_to_observe = (observed_classes + models).uniq
        singleton_class.redefine_method(:observed_classes) { models_to_observe }
      end
    end

    attr_accessor :records_processed

    def after(controller)
      self.controller = controller
      self.records_processed = []
      callback(:after)
      self.records_processed = []
      self.controller = nil
      true
    end

    def after_save(record)
      self.records_processed ||= []
      # Because the sweeper is now attached as an observer I don't want every
      # save of the record to trigger this behavior.
      return true unless controller
      return true if self.records_processed.include?(record)

      self.records_processed << record
      ActivityEngine::Activity.new.tap {|activity|
        activity.subject = record
        activity.user = current_user if respond_to?(:current_user)
        activity.activity_type = "#{controller_name}##{action_name}"
      }.save
      true
    end
  end
end
