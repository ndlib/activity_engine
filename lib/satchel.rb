require "satchel/engine"
require 'satchel/context_builder'
require 'satchel/activity_builder'

module Satchel
  module_function

  def register(class_name, method_name, activity_receiver = Satchel::Activity, &config_block)
    context_builder = ContextBuilder.new(class_name, method_name)
    activity_builder = ActivityBuilder.new(activity_receiver, config_block)
    context_builder.wrap!(activity_builder)
  end

end
