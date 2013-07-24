module ActivityEngine
  class ActivitySweeper < ActionController::Caching::Sweeper
    def self.register_models(*models)
      models.flatten!
      models.collect! { |model| model.respond_to?(:to_sym) ? model.to_s.camelize.constantize : model }
      models.each {|model|
        model.send(:include, ActiveModel::Observing) unless model.included_modules.include?(ActiveModel::Observing)
      }
      observe(models)
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
      if ! self.records_processed.include?(record)
        self.records_processed << record
        ActivityEngine::Activity.new.tap {|activity|
          activity.subject = record
          activity.user = current_user
          activity.activity_type = "#{controller_name}##{action_name}"
        }.save!
      end
      true
    end
  end
end
