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
      expect {
        TestSweeper.observe(:book)
      }.to change{TestSweeper.observed_classes}.from([]).to([Book])

      expect {
        TestSweeper.observe(:animal)
      }.to change{TestSweeper.observed_classes}.from([Book]).to([Book, Animal])
    end
  end
end
