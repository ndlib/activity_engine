require 'spec_helper'
require 'satchel/activity_builder'

describe Satchel::ActivityBuilder do
  let(:configuration) {
    lambda {|config,context|
      config.subject = context
      config.message = 'Hello World!'
    }
  }
  let(:receiver) { lambda {|attributes|} }
  subject { Satchel::ActivityBuilder.new(receiver, configuration) }
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

  describe '#subject=' do
    it 'accepts a subject that is persisted' do
      expect {
        subject.subject = persisted_object
      }.to_not raise_error
    end
    it 'rejects a subject that is not persisted' do
      expect {
        subject.subject = non_persisted_object
      }.to raise_error
    end
    it 'rejects a subject that does not respond_to persisted?' do
      expect {
        subject.subject = ""
      }.to raise_error(NoMethodError)
    end
  end

  it { should respond_to :current_user= }
  it { should respond_to :message= }
  it { should respond_to :activity_type= }
end
