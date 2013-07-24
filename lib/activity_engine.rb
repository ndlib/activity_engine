require 'activity_engine/engine'
module ActivityEngine
  module_function
  def register_models(*models)
    models.flatten!
    models.collect! { |model| model.respond_to?(:to_sym) ? model.to_s.camelize.constantize : model }
    models.each {|model|
      model.send(:include, ActiveModel::Observing) unless model.included_modules.include?(ActiveModel::Observing)
    }
    ActivitySweeper.send(:observe, models)
  end

  def register_controller(controller_name, actions)
    controller_name.constantize.send(:cache_sweeper, ActivityEngine::ActivitySweeper, only: actions)
  end

  class ActivitySweeper < ActionController::Caching::Sweeper
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


  def register(class_name, method_name, activity_receiver = ActivityEngine::Activity, &config_block)
    context_builder = ContextBuilder.new(class_name, method_name)
    activity_builder = ActivityBuilder.new(activity_receiver, config_block)
    context_builder.wrap!(activity_builder)
  end

  def extract_subject_id(object)
    Array(object.to_key).join(":")
  end

end
