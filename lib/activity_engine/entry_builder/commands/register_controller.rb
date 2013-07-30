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
          sweeper_class.observe(models)
          controller_name.constantize.module_exec(sweeper_class, action_names) do |klass, actions|
            cache_sweeper klass, only: actions
          end
        end

        protected
        def sweeper_class
          require 'activity_engine/activity_sweeper'
          ActivitySweeper
        end
      end
    end
  end
end
