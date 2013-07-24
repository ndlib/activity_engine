require 'spec_helper'
describe ActivityEngine::Statistic do
  subject{
    ActivityEngine::Statistic.new(object, opts)
  }
  let(:opts) { {activity_type: activity_type} }
  let(:object){ Object.new }

  let(:activity_type){ 'activity_type' }
  it 'should have activity_type and subject when created' do
    expect( subject.subject ).to eq object
  end

  it 'should assign activity type' do
    expect( subject.activity_type ).to eq activity_type
  end

end
