class World

  NEIGHBORS = [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]]

  attr_accessor :cells

  def initialize
    @cells = []
  end

  def add_cell(x, y)
    @cells << [x, y]
  end

  def tick!
    @new_cells = []

    @cells.each do |c|
      absolute_coords(*c).each do |coords|
        if !cell_exists?(*coords) && count_neighbors(*coords) == 3
          @new_cells << coords
        end
      end

      if count_neighbors(*c) >= 2 && count_neighbors(*c) < 4 
        @new_cells << c
      end
    end

    @cells = @new_cells
  end

  def cell_exists?(x, y)
    @cells.include? [x, y]
  end

  def count_neighbors(x, y)
    NEIGHBORS.select do |coords|
      cell_exists?(x + coords[0], y + coords[1])
    end.count
  end

  def absolute_coords(x, y)
    [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]].map { |c| [c[0] + x, c[1] + y]}
  end
end