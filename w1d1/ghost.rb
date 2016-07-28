class Game
  attr_reader :dictionary, :players, :losses
  attr_accessor :current_player, :previous_player, :fragment

  def initialize(players, dictionary=File.readlines("dictionary.txt"))
    @current_player = 0
    @losses = Hash.new(0)
    @players = players
    @dictionary = dictionary.map! { |word| word.strip }
    @fragment = ""
  end

  def record(player)
    if @losses[player].nil?
      ""
    else
      "GHOST"[0...@losses[player]]
    end
  end

  def next_player!
    holder = @current_player + 1
    @current_player =  holder % players.length
  end

  def take_turn
    puts "Current fragment: #{@fragment}. #{@players[@current_player].name}, please pick a letter."
    letter = @players[@current_player].guess
    until valid_play?(letter)
      @players[@current_player].alert_invalid_guess
      letter = @players[@current_player].guess
    end
    @fragment += letter
  end

  def valid_play?(string)
    return false unless string =~ /[a-z]/ && string.length == 1
    testfrag = @fragment + string
    dictionary.each do |word|
      return true if word.start_with?(testfrag)
    end
    false
  end

  def play_round
    until dictionary.include?(@fragment)
      take_turn
      next_player!
    end
    puts "#{@players[@current_player - 1]} loses this round!"
    @losses[@players[@current_player - 1]] += 1
    @players.each { |player| puts "#{player.name} record : #{record(player)}" }
  end

  def run
    until @players.length == 1
      play_round
      @fragment = ""
      loser = @players[@current_player - 1]
      players.delete(loser) if @losses[loser] == 5
    end
    puts "#{@players.first.name} wins!"
  end
end

class Player
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def guess
    gets.chomp.downcase
  end

  def alert_invalid_guess
    puts "invalid guess, try again"
  end
end
