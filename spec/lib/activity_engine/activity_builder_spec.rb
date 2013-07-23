require 'spec_helper'
require 'activity_engine/activity_builder'

describe ActivityEngine::ActivityBuilder do
  let(:configuration) {
    lambda {|config,context|
      config.subject = context
      config.message = 'Hello World!'
    }
  }
  let(:receiver) { lambda {|attributes|} }
  subject { ActivityEngine::ActivityBuilder.new(receiver, configuration) }
  let(:persisted_object) { double(persisted?: true, to_param: '1234')}
  let(:non_persisted_object) { double(persisted?: false, to_param: nil)}

  describe '#to_activity_data_structure' do
    it do
      expect {
        subject.to_activity_data_structure
      }.to_not raise_error
    end
  end

  describe '#call' do
    it "" do
      receiver.should_receive(:call)
      expect {
        subject.call(persisted_object)
      }.to change{subject.message}.from(nil).to("Hello World!")
    end
  end

  it { should respond_to :current_user= }
  it { should respond_to :subject= }
  it { should respond_to :message= }
  it { should respond_to :activity_type= }
end
