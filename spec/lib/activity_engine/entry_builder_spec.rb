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

  describe '.register_controller' do
    let(:model) { PersistenceLayer }
    let(:controller_name) { 'Class' }
    let(:actions) { 'new' }
    it 'delegates to ActivityEngine.register_controller' do
      engine.should_receive(:register_models).with(Array(model))
      engine.should_receive(:register_controller).with(controller_name, actions)
      subject.register_controller(controller_name, actions)
    end
  end

end