require 'spec_helper'

describe ActivityEngine::ActivitySweeper do
  class TestSweeper < ActivityEngine::ActivitySweeper
  end

  class Book
  end

  class Animal
  end

  describe '#observe' do
    it 'should allow multiple registrations' do
      # Registered via the dummy spec
      expect(TestSweeper.observed_classes).to eq([Watch])

      expect {
        TestSweeper.observe(:book)
      }.to change{TestSweeper.observed_classes}.from([Watch]).to([Watch, Book])

      expect {
        TestSweeper.observe(:animal)
      }.to change{TestSweeper.observed_classes}.from([Watch,Book]).to([Watch,Book, Animal])
    end
  end
end
