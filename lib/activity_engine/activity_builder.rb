require 'activity_engine/activity_data_structure'
require 'activity_engine/exceptions'
module ActivityEngine
  class ActivityBuilder

    attr_accessor :configuration_proc, :activity_receiver
    private :activity_receiver=, :configuration_proc=

    def initialize(activity_receiver, configuration_proc)
      unless activity_receiver.respond_to?(:call)
        raise RuntimeError, "Excpected :activity_receiver #{activity_receiver.inspect} to be callable"
      end
      unless configuration_proc.respond_to?(:call)
        raise RuntimeError, "Excpected :configuration_proc #{configuration_proc.inspect} to be callable"
      end
      self.activity_receiver = activity_receiver
      self.configuration_proc = configuration_proc
    end

    def call(context)
      configuration_proc.call(self, context)
      activity_receiver.call(self.to_activity_data_structure)
    end

    def to_activity_data_structure
      ActivityDataStructure.new.tap {|ads|
        ads.subject = subject
        ads.current_user = current_user
        ads.message = message
        ads.activity_type = activity_type
      }
    end

    def subject=(persisted_object)
      if persisted_object.persisted?
        @subject = persisted_object
      else
        raise UnpersistedSubjectError.new(persisted_object)
      end
    end

    attr_reader :subject
    attr_accessor :current_user, :message, :activity_type
  end
end
