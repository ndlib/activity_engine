require "activity_engine/engine"
require 'activity_engine/context_builder'
require 'activity_engine/activity_builder'

module ActivityEngine
  module_function

  def register(class_name, method_name, activity_receiver = ActivityEngine::Activity, &config_block)
    context_builder = ContextBuilder.new(class_name, method_name)
    activity_builder = ActivityBuilder.new(activity_receiver, config_block)
    context_builder.wrap!(activity_builder)
  end

  def extract_subject_id(object)
    Array(object.to_key).join(":")
  end

end
