module ActivityEngine
  module_function
  def for_models(*models, &configuration_block)
    entry_builder = EntryBuilder.new(*models)
    entry_builder.customize(&configuration_block)
    entry_builder.generate
  end

  def extract_subject_id(object)
    Array(object.to_key).join(":")
  end

end

require 'activity_engine/engine'
require 'activity_engine/version'
require 'activity_engine/activity_builder'
require 'activity_engine/activity_data_structure'
require 'activity_engine/context_builder'
require 'activity_engine/exceptions'
require 'activity_engine/entry_builder'
