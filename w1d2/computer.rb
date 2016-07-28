class ComputerPlayer
  attr_reader :board_size, :known_cards, :matched_cards, :previous_guess

  def receive_revealed_card(pos, value)
    @known_cards[pos] = value
  end

  def receive_match(pos1, pos2)
    @matched_cards << pos1
    @matched_cards << pos2
  end

  def prompt
    #check if theres a pair. if there is:
      #return a position with that value other than previous guess
      #put in matched cards if this guess = previous guess
    #else
      #random guess

    #set previous guess
    pair_value = check_pair
    if pair_value != nil
      guess = unmatched_cards.find{ |_, v| v == pair_value}[0]
      if @known_cards[@previous_guess] == @known_cards[guess]
  end

  def unmatched_cards
    @known_cards.reject { |k, _| @matched_cards.include?(k) }
  end

  #returns value if there is a match
  def check_pair
    max_value = @board_size**2 / 2
    max_value.times do |val|
      return val if unmatched_cards.values.count(val) == 2
    end
    nil
  end

  def rand_pos
    selections = (0...board_size).repeated_permutation(2).to_a
    selections -= known_cards.keys
    selections -= matched_cards

    selections.shuffle[0]
  end
  # attr_accessor :board_hash, :hold_val

  # def prompt
  #   if check_pair
  #     @hold_val = check_pair
  #     pos = @board_hash.find{ |_, v| v == @hold_val}[0]
  #     @board_hash.delete(pos)
  #   elsif @hold_val
  #     pos = @board_hash.find{ |_, v| v == @hold_val}[0]
  #     @board_hash.delete(pos)
  #     @hold_val = nil
  #   else
  #     selections = @board_hash.select { |_, v| v == nil }
  #     p selections
  #     pos = selections.keys.shuffle[0]
  #   end
  #   p @board_hash, @hold_val, pos
  #   pos
  # end
  #
  # def check_pair
  #   pairs = @board_hash.keys.length / 2
  #   pairs.times do |card_value|
  #     return card_value if @board_hash.values.count(card_value) == 2
  #   end
  #   nil
  # end



end
