require 'pry'
class Game
    attr_accessor :board, :player_1, :player_2
    
    WIN_COMBINATIONS = [
        [0, 1, 2], [3, 4, 5], [6, 7, 8],
        [0, 3, 6], [1, 4, 7], [2, 5, 8],
        [0, 4, 8], [2, 4, 6]
      ]
      def initialize(player_1=Players::Human.new("X"), player_2=Players::Human.new("O"), board=Board.new)
        @board = board
        @player_1 = player_1
        @player_2 = player_2
      end
     
      def current_player
        @board.turn_count.odd? ? @player_2 : @player_1
      end

      def not_current_player
        @board.turn_count.even? ? @player_2 : @player_1
      end

      def won?
        WIN_COMBINATIONS.find{|combo| @board.cells[combo[0]] != " " && @board.cells[combo[0]] == @board.cells[combo[1]] && @board.cells[combo[0]] == @board.cells[combo[2]]} || false
      end

      def draw?
        @board.full? && !won?
      end

      def over?
        draw? || won?
      end

      def winner
        if won?
          @board.cells[won?[0]]
        end
      end

      def turn
        input = current_player.move(self)
        if @board.valid_move?(input)
          @board.update(input, current_player)
        else
          puts "Invalid move! Try again..."
          turn
        end
      end

      def play
        while !over?
          turn
          @board.display
        end
        if draw?
          puts "Cat's Game!"
        elsif winner == "X"
          puts "Congratulations X!"
        elsif winner == "O"
          puts "Congratulations O!"
        end
      end
end