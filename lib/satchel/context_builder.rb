require 'satchel/exceptions'
module Satchel
  class ContextBuilder

    def initialize(class_name, method_name)
      self.class_name = class_name
      self.method_name = method_name
      extract_context_class!
      extract_method!
    end

    def wrap!(wrapper)
      # Why the i prefix? We need the local variables to be availabe
      # within the context of the module_exec.
      context_class.module_exec(method_name, context_method, wrapper) { |imethod_name, icontext_method, wrapper_proc|
        define_method(imethod_name) { |*args, &block|
          returning_value = icontext_method.bind(self).call(*args, &block)
          wrapper_proc.call(self)
          returning_value
        }
      }
    end

    attr_accessor :class_name, :method_name, :context_class, :context_method
    private :class_name, :method_name
    private
    def extract_context_class!
      if class_name.respond_to?(:constantize)
        @context_class = class_name.constantize
      else
        @context_class = class_name
      end
    end

    def extract_method!
      @context_method = context_class.instance_method(method_name)
    end

  end
end
