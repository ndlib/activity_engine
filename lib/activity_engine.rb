require 'activity_engine/engine'
module ActivityEngine
  module_function
  def register_models(*models)
    ActivitySweeper.register_models(*models)
  end

  def register_controller(controller_name, actions)
    controller_name.constantize.send(:cache_sweeper, ActivitySweeper, only: actions)
  end

  def register(class_name, method_name, activity_receiver = Activity, &config_block)
    context_builder = ContextBuilder.new(class_name, method_name)
    activity_builder = ActivityBuilder.new(activity_receiver, config_block)
    context_builder.wrap!(activity_builder)
  end

  def extract_subject_id(object)
    Array(object.to_key).join(":")
  end

end
