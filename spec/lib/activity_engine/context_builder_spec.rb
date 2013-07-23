require 'spec_helper'
require 'activity_engine/context_builder'

describe ActivityEngine::ContextBuilder do
  class MockContext
    attr_reader :parameter, :counter
    def initialize(parameter)
      @parameter = parameter
      @counter = 0
    end
    def increment_counter; @counter += 1; end
  end
  let(:class_name) { 'MockContext' }

  subject { ActivityEngine::ContextBuilder.new(class_name, method_name) }

  describe 'wrap!' do
    let(:wrapper_logger) { [] }
    let(:parameter) { 'hello world' }
    let(:object) { MockContext.new(parameter)}
    let(:method_name) { 'increment_counter' }
    let(:wrapper) {
      lambda { |context|
        wrapper_logger << context
      }
    }
    it 'wraps the context method and yields' do
      subject.wrap!(wrapper)
      expect {
        expect {
          object.increment_counter
        }.to change { wrapper_logger.count }.by(1)
      }.to change { object.counter }.by(1)

      expect {
        expect {
          object.increment_counter
        }.to change { wrapper_logger.count }.by(1)
      }.to change { object.counter }.by(1)

      expect(wrapper_logger).to eq([object, object])
    end

    it 'preserves the return value' do
      subject.wrap!(wrapper)
      expect(object.increment_counter).to eq(1)
    end

    it 'only wraps a method once' do
      wrapper = lambda {|a|}

      subject.wrap!(wrapper)
      subject.wrap!(wrapper)
      subject.wrap!(wrapper)

      wrapper.should_receive(:call).once
      object.increment_counter
    end
  end

  describe 'method extraction' do
    describe 'for existing instance method' do
      let(:method_name) { 'increment_counter' }
      it 'extracts the context class' do
        expect(subject.context_class).to eq(MockContext)
      end

      it 'extracts the context method' do
        expect(subject.context_method).to eq(MockContext.instance_method(:increment_counter))
      end
    end

    describe 'for missing instance method' do
      let(:method_name) { 'method_does_not_exist' }
      it {
        expect{
          subject
        }.to raise_error(NameError)
      }
    end
  end

end
