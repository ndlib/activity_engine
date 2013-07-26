module ActivityEngine
  class EntryBuilder
    attr_accessor :models
    private :models=
    def initialize(*model_names)
      yield(self) if block_given?
      self.models = model_names
    end

    def register_call(klass_name, instance_method_name, &configuration_proc)
      engine.register_call(klass_name, instance_method_name, &configuration_proc)
    end

    def register_controller(controller_name, action_names)
      engine.register_models(models)
      engine.register_controller(controller_name, action_names)
    end

    attr_writer :engine
    private
    def engine
      @engine ||= ActivityEngine
    end
  end
end