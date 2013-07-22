require 'spec_helper'

module Satchel
  describe Activity do
    let(:object) { PersistenceLayer.new }
    subject { Satchel::Activity.new }

    it 'should marshal the subject' do
      subject.subject = object
      expect(subject.subject).to eq(object)
    end

    it 'should capture the subject id' do
      subject.subject = object
      expect(subject.subject_id).to eq(object.to_param)
    end

    it 'should capture the subject type' do
      subject.subject = object
      expect(subject.subject_type).to eq(object.class.to_s)
    end

  end
end
