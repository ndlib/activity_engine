require 'activity_engine/entry_builder/command'

module ActivityEngine
  class EntryBuilder
    module Commands
      class RegisterController < ActivityEngine::EntryBuilder::Command
        attr_reader :controller_name, :action_names
        def initialize(builder,controller_name, action_names)
          super(builder)
          @controller_name = controller_name
          @action_names = action_names
        end

        def call
          engine.register_models(models)
          engine.register_controller(controller_name, action_names)
        end
      end
    end
  end
end
