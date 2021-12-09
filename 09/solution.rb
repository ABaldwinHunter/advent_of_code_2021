# day 9
#

# build a grid
#

file = "sample.txt"
# file = "input.txt"
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

  def ==(point)
    row_index == point.row_index && col_index == point.col_index
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

def find_basin(rows, layer, basin_so_far)
  print "*"
  neighbors_that_could_be_basin = layer.flat_map do |point|
    point.get_neighbors_from_grid(rows).reject { |point| point.value == 9 }.reject do |point|
      (basin_so_far.any? { |basin_point| point == basin_point }) || layer.any? { |layer_point| layer_point == point }
    end
  end.uniq { |p| [p.row_index, p.col_index] }

  if neighbors_that_could_be_basin.none?
    basin_so_far
  else
    next_layer = []

    neighbors_that_could_be_basin.each do |point|
      next_gen_neighbors = point.get_neighbors_from_grid(rows).reject do |point|
        (basin_so_far.any? { |basin_point| point == basin_point }) || layer.any? { |layer_point| layer_point == point }
      end

      is_a_low_point = next_gen_neighbors.all? { |neighbor| neighbor.value > point.value }

      next_layer << point #if is_a_low_point
      basin_so_far << point
    end

    find_basin(rows, next_layer.uniq { |point| [point.row_index, point.col_index] }, basin_so_far)
  end
end

# first solution - worked for sample but got stack level too deep error on input
#
# def find_basin(rows, start_point, basin_so_far)
#   print "*"
#   neighbors_that_could_be_basin = start_point.get_neighbors_from_grid(rows).reject { |point| point.value == 9 }.reject { |point| basin_so_far.any? { |basin_point| point == basin_point } }

#   if neighbors_that_could_be_basin.none?
#     basin_so_far
#   else
#     neighbors_that_could_be_basin.each do |point|
#       next_gen_neighbors = point.get_neighbors_from_grid(rows).reject { |point| basin_so_far.any? { |basin_point| point == basin_point } }

#       is_a_low_point = next_gen_neighbors.all? { |neighbor| neighbor.value > point.value }

#       basin_so_far << point if is_a_low_point
#     end

#     neighbors_that_could_be_basin.each do |point|
#       basin_so_far += find_basin(rows, point, basin_so_far)
#     end

#     basin_so_far.uniq
#   end
# end

basins = low_points.map do |low_point|
  find_basin(rows, [low_point], [low_point])
end

sizes = basins.map do |basin|
  basin.uniq { |p| [p.row_index, p.col_index] }.count
end

biggest_to_smallest = sizes.sort.reverse

answer = biggest_to_smallest[0] * biggest_to_smallest[1] * biggest_to_smallest[2]

puts "answer #{answer}"

# 12888495359984
# answer too big


# new answer 752,752 # too low :(((
# 987840
