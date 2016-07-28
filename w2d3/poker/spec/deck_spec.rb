require 'rspec'
require 'deck'

describe Deck do
  subject(:deck) { Deck.new }

  describe '#initialize' do
    it "has an array of cards" do
      expect(deck.cards).to be_an_instance_of(Array)
    end

    it "has 52 cards" do
      expect(deck.cards.length).to eq(52)
    end

    it "has the right cards" do
      values = deck.cards.map { |card| card.value }
      suits = deck.cards.map { |card| card.suit }

      set_values = (2..14).to_a * 4
      set_suits = [:h, :c, :d, :s] * 13

      expect(values.sort).to eq(set_values.sort)
      expect(suits.sort).to eq(set_suits.sort)
    end
  end

  describe '#shuffle!' do
    it "shuffles the deck" do
      current_deck = deck.cards.dup
      deck.shuffle!
      expect(deck.cards).to_not eq(current_deck)
    end
  end


end
