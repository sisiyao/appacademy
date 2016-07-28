require_relative 'card'

class Deck
  attr_reader :cards

  def initialize
    @cards = []
    create_deck
  end

  def create_deck
    suits = [:h, :c, :d, :s]
    values = (2..14).to_a
    suits.each do |suit|
      values.each do |value|
        @cards << Card.new(suit, value)
      end
    end
  end

  def shuffle!
    @cards.shuffle!
  end
end
