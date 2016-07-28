class Hand

  TYPES = [:straight_flush,
          :four_kind,
          :full_house,
          :flush,
          :straight,
          :three_kind,
          :two_pair,
          :one_pair,
          :high_card]

  attr_accessor :cards

  def initialize
    @cards = []
    @card_count = Hash.new(0)
    @suit_count = nil
    @type = nil
  end

  def get_card_count
    values = @cards.map { |card| card.value }
    values.each do |value|
      @card_count[value] += 1
    end
  end

  def get_suit_count
    suits = @cards.map { |card| card.suit }
    @suit_count = suits.uniq.length
  end

  def diffs_one?
    values = @cards.map { |card| card.value }
    diffs = []

    @values.each_with_index do |value, i|
      next if i == values.length - 1
      diffs << values[i + 1] - value
    end

    diffs.all? { |diff| diff == 1 }
  end

  def get_type
    if diffs_one?
      if @suit_count == 1
        @type = :straight_flush
      else
        @type = :straight
      end
    elsif @suit_count == 1
      @type = :flush
    elsif @card_count.values.include?(4)
      @type = :four_kind
    elsif @card_count.values.include?(3)
      if @card_count.values.include?(2)
        @type = :full_house
      else
        @type = :three_kind
      end
    elsif @card_count.values.count(2) == 2
      @type = :two_pair
    elsif @card_count.values.include?(2)
      @type = :one_pair
    else
      @type = :high_card
    end
  end

  def compare(other_hand)
    if self.type == other_hand.type
      case self.type
      when :straight_flush, :flush, :straight, :high_card
        comparison = self.cards.max <=
    else
      comparison = TYPE.index(self.type) <=> TYPE.index(other_hand.type)
      return self if comparison == 1
      return other_hand
    end
  end
end
