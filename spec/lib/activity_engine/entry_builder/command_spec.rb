require 'spec_helper'
require 'activity_engine/entry_builder/command'

describe ActivityEngine::EntryBuilder::Command do
  let(:builder) { double(engine: engine, models: models) }
  let(:engine) { double }
  let(:models) { double }
  subject { ActivityEngine::EntryBuilder::Command.new(builder) }

  it 'should delegate #models to #builder' do
    expect(subject.models).to eq(models)
  end
  it 'should delegate #engine to #builder' do
    expect(subject.engine).to eq(engine)
  end
  it 'is an abstract class' do
    expect{subject.call}.to raise_error(NotImplementedError)
  end
end
