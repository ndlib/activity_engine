require 'activity_engine/entry_builder/commands'
module ActivityEngine
  class EntryBuilder
    attr_accessor :models
    private :models=
    def initialize(*models)
      yield(self) if block_given?
      models.flatten!
      models.collect! { |model| model.respond_to?(:to_sym) ? model.to_s.camelize.constantize : model }
      self.models = models
    end

    def customize(&customization_block)
      return unless customization_block
      customization_block.call(self)
    end

    def generate
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
