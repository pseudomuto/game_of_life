module GameOfLife
  # Public: The main class for playing the Game of Life
  #
  # Examples
  #
  #     game = GameOfLife::Game.new(5, 5, [2, 1], [2, 2], [2, 3])
  #     game.play(2) do
  #       puts game.to_s
  #     end
  class Game

    # Public: Create a new Game of Life
    #
    # rows - the number of rows in the world
    # cols - the number of columns in the world
    # live_cells - an optional array of live cells
    #
    # Examples
    #
    #     GameOfLife::Game.new(5, 5, [2, 1], [2, 2], [2, 3])
    #     # => 00000\n00000\n01110\n00000\n00000
    #
    # Returns a new game
    def initialize(rows, cols, *live_cells)
      @board = Board.new(rows, cols)
      @board.spawn_cells(*live_cells) if live_cells
    end

    # Public: Play the game
    #
    # num_generations - the number of generations to play (default = 1)
    #
    # Examples
    #
    #     game = GameOfLife::Game.new(5, 5, [2, 1], [2, 2], [2, 3])
    #     game.play(2)
    #
    #     # can call with a block to do something
    #     # immediately after each "tick"
    #     game.play(2) do
    #       puts game.to_s
    #     end
    #
    def play(num_generations = 1)
      num_generations.times do
        tick
        yield if block_given?
      end
    end

    def to_s
      @board.to_s
    end

    private

    def tick
      new_board = Board.new(@board.row_count, @board.column_count)

      @board.each_row do |row, y|
        @board.each_cell_in_row(y) do |cell, x|
          live_neighbours = @board.live_neighbour_count(y, x)
          if cell.zero?
            new_board.spawn_cells([y, x]) if live_neighbours == 3
          else
            if live_neighbours == 2 or live_neighbours == 3
              new_board.spawn_cells([y, x])
            end
          end
        end
      end

      @board = new_board
    end
  end
end