require 'spec_helper'



describe ActivityEngine::EntryBuilder do
  let(:engine) { double }
  let(:models) { 'PersistenceLayer' }
  subject {
    ActivityEngine::EntryBuilder.new(models).tap {|builder|
      builder.engine = engine
    }
  }

  before(:each) do
  end

  describe '.register_call' do
    let(:klass_name) { 'Class' }
    let(:instance_method_name) { 'new' }
    it 'delegates to ActivityEngine.register_call' do
      engine.should_receive(:register_call).with(klass_name, instance_method_name)
      subject.register_call(klass_name, instance_method_name)
    end
  end

  describe '.register_controller' do
    let(:klass_name) { 'Class' }
    let(:actions) { 'new' }
    it 'delegates to ActivityEngine.register_call' do
      engine.should_receive(:register_models).with(Array(models))
      engine.should_receive(:register_controller).with(klass_name, actions)
      subject.register_controller(klass_name, actions)
    end
  end

end