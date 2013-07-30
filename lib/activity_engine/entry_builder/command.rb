module ActivityEngine
  class EntryBuilder
    class Command
      attr_reader :builder
      def initialize(builder)
        @builder = builder
      end
      delegate :engine, :models, to: :builder

      def call
        raise NotImplementedError,
              "Method #call should be overriden in child classes"
      end

    end
  end
end
