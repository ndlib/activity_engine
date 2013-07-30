require 'spec_helper'



describe ActivityEngine::EntryBuilder do
  let(:engine) { double }
  let(:model) { PersistenceLayer }
  subject {
    ActivityEngine::EntryBuilder.new(model).tap {|builder|
      builder.engine = engine
    }
  }

  before(:each) do
  end

  it { should respond_to :register_call }
  it { should respond_to :register_controller }

end