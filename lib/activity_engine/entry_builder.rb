require 'activity_engine/entry_builder/commands'
module ActivityEngine
  class EntryBuilder
    attr_accessor :models
    private :models=
    def initialize(*model_names)
      yield(self) if block_given?
      self.models = model_names
    end

    def method_missing(method_name, *args, &block)
      command_name = command_name_for_method(method_name)
      if Commands.const_defined?(command_name)
        command_class = Commands.const_get(command_name)
        command_class.new(self, *args, &block).call
      else
        super
      end
    end

    def respond_to_missing?(method_name, include_private=false)
      command_name = command_name_for_method(method_name)
      Commands.const_defined?(command_name) || super
    rescue NameError
      super
    end

    attr_writer :engine
    private
      def engine
        @engine ||= ActivityEngine
      end

      def command_name_for_method(method_name)
        method_name.to_s.gsub(/(?:^|_)([a-z])/) { $1.upcase }
      end

  end
end
