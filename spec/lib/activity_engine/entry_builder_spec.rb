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

  describe '.register_call' do
    let(:instance_method_name) { 'new' }
    it 'delegates to ActivityEngine.register_call' do
      engine.should_receive(:register_call).with(model, instance_method_name)
      subject.register_call(instance_method_name)
    end
  end

  describe '.register_controller' do
    let(:model) { PersistenceLayer }
    let(:controller_name) { 'Class' }
    let(:actions) { 'new' }
    it 'delegates to ActivityEngine.register_call' do
      engine.should_receive(:register_models).with(Array(model))
      engine.should_receive(:register_controller).with(controller_name, actions)
      subject.register_controller(controller_name, actions)
    end
  end

end