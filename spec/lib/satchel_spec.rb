require 'spec_helper'
require 'satchel'

describe Satchel do
  class Cat < PersistenceLayer
    def initialize(name)
      super()
      @name = name
    end
    attr_reader :name
    def eat(food); food; end
  end
  Food = Struct.new(:name)

  describe '.register' do
    let(:cat) { Cat.new('Beautiful Steve') }
    let(:food) { Food.new('catsup') }
    let(:receiver) { Satchel::Activity }

    it 'reports when the method is called' do
      Satchel.register(Cat, :eat, receiver) do |config, context|
        config.subject = context
        config.activity_type = 'Cat#eat'
      end
      cat.eat(food)
      expect(receiver.last.subject).to eq(cat)
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
