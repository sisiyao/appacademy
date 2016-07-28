require 'set'

class WordChainer
  def initialize(dictionary_filename = "dict.txt")
    @dictionary = Set.new

    File.foreach(dictionary_filename) do |line|
      @dictionary.add(line.chomp)
    end
  end

  def adjacent_words(word)
    same_length_words = @dictionary.select { |w| w.length == word.length && w != word }
    adj_words = Set.new

    word.each_char.with_index do |char, i|
      same_length_words.each do |w|
        adj_words.add(w) if chunk_match(word, w, i)
      end
    end
    adj_words
  end

  def chunk_match(word1, word2, index)
    if index == 0
      return word1[index+1..-1] == word2[index+1..-1]
    elsif index == word1.length - 1
      return word1[0...index] == word2[0...index]
    else
      lhs_equal = (word1[0...index] == word2[0...index])
      rhs_equal = (word1[index+1..-1] == word2[index+1..-1])
      lhs_equal && rhs_equal
    end
  end

  def run(source, target)
    @current_words = [source]
    @all_seen_words = { source => nil }
    until @current_words.empty?
      new_current_words = []
      explore_current_words(new_current_words, target)
      @current_words = new_current_words
    end

    p build_path(target)
  end

  def explore_current_words(new_current_words, target)
    @current_words.each do |curr_word|
      current_adj = adjacent_words(curr_word)
      if current_adj.include?(target)
        @all_seen_words[target] = curr_word
        return
      end

      current_adj.each do |adj_word|
        next if @all_seen_words.keys.include?(adj_word)
        @all_seen_words[adj_word] = curr_word
        new_current_words << adj_word
      end
    end

    # new_current_words.each do |new_word|
    #   print "#{@all_seen_words[new_word]} => #{new_word} | "
    # end
  end

  def build_path(target)
    path = [target]
    until @all_seen_words[target].nil?
      previous_word = @all_seen_words[target]
      path << previous_word
      target = previous_word
    end

    path.reverse
  end

end
