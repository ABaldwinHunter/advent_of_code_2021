# day 9
#

# build a grid
#

# file = "sample.txt"
file = "input.txt"
#

rows = File.read(file).split("\n").map { |row| row.split("").map(&:to_i) } # [[1,2,3,4],[3,5,6] # 2d array

# walk the grid and at each spot check if it's a low point. if so, increment count
#

low_points = []

rows.each.with_index do |row, row_index|
  row.each.with_index do |location, col_index|
    neighbors = [
      [(row_index - 1), col_index], # above
      [(row_index + 1), col_index], # below
      [row_index, (col_index + 1)], # right
      [row_index, (col_index - 1)], # left
    ].reject { |pair| pair.any? { |num| num < 0 } }

    is_a_low_point = neighbors.all? do |coord|
      value = rows[coord.first] && rows[coord.first][coord.last]

      value.nil? || (value > location)
    end

    low_points << location if is_a_low_point
  end
end

sum = low_points.map { |point| point + 1 }.sum

puts "sum is #{sum}"
