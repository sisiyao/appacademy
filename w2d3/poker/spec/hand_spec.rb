require 'rspec'
require 'hand'

describe Hand do
  subject(:hand) { Hand.new }
  let(:hand2) {Hand.new}
  let(:prc) { proc { |suit, value| double('card', suit: suit, value: value) } }
  let(:straight_flush) { [[:h, 2], [:h, 3], [:h, 4], [:h, 5], [:h, 6]].map(&prc) }
  let(:four_kind) { [[:h, 2], [:c, 2], [:s, 2], [:d, 2], [:h, 6]].map(&prc) }
  let(:full_house) { [[:h, 2], [:c, 2], [:s, 2], [:h, 6], [:s, 6]].map(&prc) }
  let(:flush) { [[:h, 2], [:h, 9], [:h, 4], [:h, 5], [:h, 6]].map(&prc) }
  let(:straight) { [[:h, 2], [:c, 3], [:s, 4], [:h, 5], [:c, 6]].map(&prc) }
  let(:three_kind) { [[:h, 2], [:c, 3], [:s, 6], [:h, 6], [:c, 6]].map(&prc) }
  let(:two_pair) { [[:h, 2], [:c, 2], [:s, 6], [:h, 6], [:c, 9]].map(&prc) }
  let(:one_pair) { [[:h, 2], [:c, 3], [:s, 6], [:h, 6], [:c, 9]].map(&prc) }
  let(:high_card) { [[:h, 2], [:c, 3], [:s, 10], [:h, 14], [:c, 9]].map(&prc) }

  describe '#initialize' do
    it 'has no cards when initialized' do
      expect(hand.cards).to be_empty
    end

    it 'has no type when initialized' do
      expect(hand.type).to be_nil
    end
  end

  describe '#compare' do
    it 'knows a straight flush is higher than a four of a kind' do
      expect(straight_flush.compare(four_kind)).to eq(straight_flush)
    end

    it 'knows a four of a kind is higher than a full house' do
      expect(four_kind.compare(full_house)).to eq(four_kind)
    end

    it 'knows a full house is higher than a flush' do
      expect(full_house.compare(flush)).to eq(full_house)
    end

    it 'knows a flush is higher than a straight' do
      expect(flush.compare(straight)).to eq(flush)
    end

    it 'knows a straight is higher than a three of a kind' do
      expect(straight.compare(three_kind)).to eq(straight)
    end

    it 'knows a three of a kind is higher than a two pair' do
      expect(three_kind.compare(two_pair)).to eq(three_kind)
    end

    it 'knows a two pair is higher than a one pair' do
      expect(two_pair.compare(one_pair)).to eq(two_pair)
    end

    it 'knows a one pair is higher than a high card' do
      expect(one_pair.compare(high_card)).to eq(one_pair)
    end
  end


end
