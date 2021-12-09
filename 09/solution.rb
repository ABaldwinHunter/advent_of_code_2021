# day 9
#

# build a grid
#

# file = "sample.txt"
file = "input.txt"
#


# walk the grid and at each spot check if it's a low point. if so, increment count
#

low_points = []

class Point
  attr_reader :row_index, :col_index, :value

  def initialize(row_index, col_index, value)
    @row_index = row_index
    @col_index = col_index
    @value = value
  end

  def get_neighbors_from_grid(grid)
    neighbors = [
      [(row_index - 1), col_index], # above
      [(row_index + 1), col_index], # below
      [row_index, (col_index + 1)], # right
      [row_index, (col_index - 1)], # left
    ].reject { |pair| pair.any? { |num| num < 0 } }

    neighbors.map do |coord|
      neighbor = grid[coord.first] && grid[coord.first][coord.last]

      unless neighbor.nil?
        Point.new(coord.first, coord.last, neighbor.value)
      end
    end.compact
  end
end

rows = File.read(file).split("\n").map.with_index do |row, row_index|
  row.split("").map.with_index do |location, col_index|
    Point.new(row_index, col_index, location.to_i)
  end
end # [[1,2,3,4],[3,5,6] # 2d array of points

rows.each.with_index do |row, row_index|
  row.each.with_index do |point, col_index|

    neighbors = point.get_neighbors_from_grid(rows)

    is_a_low_point = neighbors.all? { |neighbor| neighbor.value > point.value }

    low_points << point if is_a_low_point
  end
end

sum = low_points.map { |point| point.value + 1 }.sum

puts "sum is #{sum}"

# part 2
#

# start from low_points

# low_points.map do |low_point|
#   basin = low_point.build_basin
# end

