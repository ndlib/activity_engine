require 'activity_engine/entry_builder/command'

module ActivityEngine
  class EntryBuilder
    module Commands
      class RegisterCall < ActivityEngine::EntryBuilder::Command
        def initialize(builder, method_name, &configuration_proc)
          super(builder)
          @method_name = method_name
          @configuration_proc = configuration_proc
        end

        def call
          models.each do |model|
            engine.register_call(model, @method_name, &@configuration_proc)
          end
        end
      end
    end
  end
end