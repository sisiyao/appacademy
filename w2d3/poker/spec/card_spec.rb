require 'rspec'
require 'card'

describe Card do
  subject(:card) { Card.new(:h, 5) }

  describe '#initialize' do
    it 'creates a card object' do
      expect(card).to be_an_instance_of(Card)
    end

    it 'initializes with a value' do
      expect(card.value).to be_truthy
    end

    it 'initializes with a suit' do
      suits = [:h, :c, :d, :s]
      expect(suits).to include(card.suit)
    end
  end
end
