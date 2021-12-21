# day 15
# pairing with matt
# dijkstra
#
# forth # factor

require_relative './dijkstra.rb'
require_relative './vertex.rb'
require_relative './big_grid.rb'


file = 'sample.txt'
# file = 'input.txt'

# part one
#
matrix = File.read(file).split("\n").map.with_index do |row, i|
  row.split("").map.with_index do |str_cost, j|
    Vertex.new(cost_to_move_to: str_cost.to_i, coords: [i, j])
  end
end

matrix[0][0].minimum_cost = 0

row_count = matrix.length
col_count = matrix.first.length

target = matrix[(row_count - 1)][(col_count - 1)]

find_shortest_path(matrix, target)

# part 2

# giant grid

rows = File.read(file).split("\n")

raw_tile = rows.map do |row|
  row.split("").map(&:to_i)
end

untiled = build_new_grid(raw_tile)
# require 'pry'; binding.pry

matrix = untiled.map.with_index do |row, i|
  row.map.with_index do |cost, j|
    Vertex.new(cost_to_move_to: cost, coords: [i, j])
  end
end

matrix[0][0].minimum_cost = 0

row_count = matrix.length
col_count = matrix.first.length

target = matrix[(row_count - 1)][(col_count - 1)]

require 'pry'; binding.pry

find_shortest_path(matrix, target)

# 200 is too low
