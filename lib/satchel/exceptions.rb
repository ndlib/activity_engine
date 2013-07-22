module Satchel
  class UnpersistedSubjectError < RuntimeError #:nodoc:
    def initialize(subject)
      super("#{subject.inspect} is not persisted")
    end
  end
end
