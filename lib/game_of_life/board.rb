module GameOfLife
  # Internal: Represents a grid to be used by the Game of Life
  class Board
    # Internal: the number of rows in the grid
  	attr_reader :row_count

    # Internal: the number of columns per row
    attr_reader :column_count

    # Internal: Create a new game board
    #
    # rows - the number of rows in the grid
    # cols - the number of columns per row
    #
    # Examples
    #     
    #     board = GameOfLife::Board.new(5, 5)
    #
    # Returns a new game board
  	def initialize(rows, cols)
  	  @row_count = rows
  	  @column_count = cols
  	  @cells = Array.new(rows) { Array.new(cols, 0) }
  	end

    # Internal: Set the specified cell indices to live
    #
    # *cells - an array of cell indices to become live
    #
    # Examples
    #
    #     my_board.spawn_cells
    #     my_board.spawn_cells([2, 1], [2, 2])
  	def spawn_cells(*cells)
  	  cells.each do |row,col|
  	  	@cells[row][col] = 1
  	  end
	  end

    # Internal: Iterator over each row
    #
    # Yields the row (Array) and index of the iteration
    #
    # Examples
    #
    #     my_board.each_row do |row, y|
    #       puts "Looking at row #{y}, I find #{row.size} cells"
    #     end
    def each_row
      @cells.each_with_index do |row, y|
        yield(row, y)
      end
    end

    # Internal: Iterate over the columns in the specified row
    #
    # Yields the cells (Integers) and index of the iteration
    #
    # row_index - the row index to iterator over
    #
    # Examples
    #
    #     my_board.each_cell_in_row(0) do |cell, x|
    #       puts "The cell at (0, #{x}) = #{cell}"
    #     end
    def each_cell_in_row(row_index)
      @cells[row_index].each_with_index do |cell, x|
        yield(cell, x)
      end
    end

    # Internal: Count the number of live cells surrounding this cell
    #
    # row - the row index for the cell
    # col - the column index for the cell
    # 
    # Examples
    # 
    #     my_board.live_neighbour_count(0, 1)
    #
    # Returns the number of live neighbour cells
    def live_neighbour_count(row, col)
      neighbouring_cells(row, col).count {|cell| cell == 1 }
    end

  	def to_s
  	  @cells.inject('') do |str, row|
  	  	row.each {|cell| str << cell.to_s }
  	  	str << "\n"
  	  end
  	end

    private

    def neighbouring_cells(row, col)
      (-1..1).inject([]) do |values, dy|
        (-1..1).each do |dx|
          unless dx.zero? and dy.zero?
            current_row = row + dy
            current_col = col + dx

            # wrap around...
            current_row = 0 unless current_row < row_count
            current_col = 0 unless current_col < column_count

            values << @cells[current_row][current_col]
          end
        end

        values
      end
    end
  end
end