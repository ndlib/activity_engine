require 'spec_helper'
require 'activity_engine'

describe ActivityEngine do
  class Cat < PersistenceLayer
    def initialize(name)
      super()
      @name = name
    end
    attr_reader :name
    def eat(food); food; end
  end
  Food = Struct.new(:name)

  describe '.register_call' do
    let(:cat) { Cat.new('Beautiful Steve') }
    let(:food) { Food.new('catsup') }
    let(:receiver) { ActivityEngine::Activity }

    it 'reports when the method is called' do
      ActivityEngine.for_models(:cat) do |builder|
        builder.register_call(:eat) do |activity, context|
          activity.subject = context
          activity.activity_type = 'Cat#eat'
        end
      end
      cat.eat(food)
      expect(ActivityEngine::Activity.last.subject).to eq(cat)
    end
  end

  describe '.extract_subject_id' do
    it 'with multi-values' do
      obj = double(to_key: ['a','b'] )
      expect(ActivityEngine.extract_subject_id(obj)).to eq('a:b')
    end
    it 'with single value' do
      obj = double(to_key: ['a'] )
      expect(ActivityEngine.extract_subject_id(obj)).to eq('a')
    end
    it 'with string' do
      obj = double(to_key: 'a' )
      expect(ActivityEngine.extract_subject_id(obj)).to eq('a')
    end
  end

  describe 'entry creation' do
    it 'creates an entry for a persisted object'
    it 'requires an object to be persisted'
    it 'extracts the requesting user from the context'
    it 'extracts the entry type from the context'
  end

  describe 'entry finder scopes' do
    it 'has a scope for finding based on the persisted object'
    it 'has a scope for finding based on a user'
    it 'has a scope for finding based on an entry type'
  end
end
