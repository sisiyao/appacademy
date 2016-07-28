require_relative 'board'
require_relative 'card'
require_relative 'computer'
require_relative 'human'

class Game
  attr_reader :board, :player

  def initialize(size, player)
    @board = Board.new(Array.new(size) { Array.new(size) })
    @player = player
    @player.board_size = size
  end

  def get_guess
    x, y = @player.prompt
    guess_card = @board.grid[x][y]
    guess_card.reveal

    guess_card
  end


  def play
    @board.populate
    @board.render
    until @board.won?
      system("clear")
      @board.render

      first_guess = get_guess
      @board.render
      second_guess = get_guess
      @board.render


      if first_guess.value != second_guess.value
        first_guess.hide
        second_guess.hide
      end

      sleep(2)
    end

    puts "Good job!"
  end
end
