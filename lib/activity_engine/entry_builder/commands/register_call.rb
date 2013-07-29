require 'activity_engine/entry_builder/command'

module ActivityEngine
  class EntryBuilder
    module Commands
      class RegisterCall < ActivityEngine::EntryBuilder::Command
        attr_reader :method_name
        attr_reader :configuration_proc
        def initialize(builder, method_name, &configuration_proc)
          super(builder)
          @method_name = method_name
          @configuration_proc = configuration_proc
        end

        def call
          models.each do |model|
            context_wrapper = context_builder.call(model, method_name)
            activity = activity_builder.call(activity_receiver, configuration_proc)
            context_wrapper.wrap!(activity)
          end
        end

        attr_writer :activity_receiver, :context_builder, :activity_builder
        def activity_receiver
          @activity_receiver ||= ActivityEngine::Activity
        end

        def context_builder
          @context_builder ||= ContextBuilder.method(:new)
        end

        def activity_builder
          @activity_builder ||= ActivityBuilder.method(:new)
        end
      end
    end
  end
end