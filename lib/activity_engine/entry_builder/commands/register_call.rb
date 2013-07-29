require 'activity_engine/entry_builder/command'

module ActivityEngine
  class EntryBuilder
    module Commands
      class RegisterCall < ActivityEngine::EntryBuilder::Command
        def initialize(builder, class_name, method_name, &configuration_proc)
          super(builder)
          @class_name = class_name
          @method_name = method_name
          @configuration_proc = configuration_proc
        end

        def call
          engine.register_call(@class_name, @method_name, &@configuration_proc)
        end
      end
    end
  end
end