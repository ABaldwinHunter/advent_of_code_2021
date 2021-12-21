# day 15
# pairing with matt
# dijkstra
#
# forth
# factor

# each vertex - unvisited, currently visting, visited
# best cost
#
# initialize with all inifinities (or nil) and starting point is 0
#
# matrix of objects - keep metadata inside
#

file = 'sample.txt'
# file = 'input.txt'
#

require_relative './priority_queue'

def neighbors(matrix, vertex)
  x, y = vertex.coords

  coords = [
    [(x + 1), y],
    [(x - 1), y],
    [x, (y + 1)],
    [x, (y - 1)],
  ].reject { |point| point.any? { |coord| coord < 0 } } # ruby array -1 returns something

  coords.map do |coord|
    matrix[coord.first] && matrix[coord.first][coord.last]
  end.compact
end

class Vertex
  include Comparable

  attr_reader :cost_to_move_to, :coords
  attr_accessor :minimum_cost

  def initialize(cost_to_move_to:, minimum_cost: Float::INFINITY, coords:)
    @cost_to_move_to = cost_to_move_to
    # @shortest_cost_to_get_to_from_source
    @minimum_cost = minimum_cost
    @coords = coords
  end

  def <=>(other_vertex)
    # the smaller the cost to move to, the higher the
    # priority
    other_vertex.minimum_cost <=> minimum_cost
  end

  def to_s
    "vertex with cost #{cost_to_move_to}, minimum_path_cost #{minimum_cost}"
  end
end

matrix = File.read(file).split("\n").map.with_index do |row, i|
  row.split("").map.with_index do |str_cost, j|
    Vertex.new(cost_to_move_to: str_cost.to_i, coords: [i, j])
  end
end

matrix[0][0].minimum_cost = 0

def dijkstra(matrix)
  distances = {} # coords => integer
  q = PriorityQueue.new
  start_vertex = matrix[0][0]

  distances[start_vertex.coords] = 0

  q << start_vertex

  while q.any? do
    current = q.pop
    puts "q is "
    puts "#{q}"

    puts "current is #{current}"

    neighbors = neighbors(matrix, current)

    neighbors.each do |neighbor|
      # compare risk from the current vertex to the neighbor to what neighbor already has as min
      curr_distance = current.minimum_cost

      neighbor_distance = distances[neighbor.coords]

      new_cost = curr_distance + neighbor.cost_to_move_to

    rescue
      require 'pry'; binding.pry

      if (
          neighbor_distance.nil? || (
            curr_distance &&
            (new_cost < neighbor.minimum_cost)
          ))
        distances[neighbor.coords] = new_cost
        neighbor.minimum_cost = (curr_distance + neighbor.cost_to_move_to)
        q << neighbor
      end
    end
  end

  distances
end

def find_shortest_path(matrix, destination)
  distances = dijkstra(matrix)

  shortest = distances[destination.coords]

  puts "shortest distance to destination is #{shortest}"
end

row_count = matrix.length
col_count = matrix.first.length

target = matrix[(row_count - 1)][(col_count - 1)]

find_shortest_path(matrix, target)

# giant grid
#
def build_grid(five_by_five_tile)
  big_grid = [
    [five_by_five_tile],
    [],
    [],
    [],
    [],
  ]

  # across the first row
  # then down from each column
  #
  4.times do
    five_by_five_tile.each.with_index do |row, i|
      row.each.with_index do |item, j|
        if item == 9
          item = 1
        else
          item += 1
        end
      end
    end

    big_grid[0] << five_by_five_tile
  end

  big_grid[0].each.with_index do |tile, first_row_index|
    [1, 2, 3, 4].each do |non_first_row_row|
      tile.each.with_index do |row, i|
        row.each.with_index do |item, j|
          if item == 9
            item = 1
          else
            item += 1
          end
        end
      end

      big_grid[non_first_row_row][first_row_index] = tile
    end
  end

  big_grid
end

raw_tile = File.read(file).split("\n").map do |row|
  row.split("").map do |str_cost|
    str_cost.to_i
  end
end

big_grid = build_grid(raw_tile) # 5 x 5 tiles

# [
#   [ ], [ ] , [ ],
#   [ ], [ ] , [ ],
# ]

# require 'pry'; binding.pry

five_by_25_rows = big_grid.map do |row_of_five_tiles|
  new_rows = [] # removing the vertical dividers for this layer

  [0, 1, 2, 3, 4].each do |i|
    row_of_five_tiles.each do |tile|
      # require 'pry'; binding.pry
      new_rows[i] ||= []

      new_rows[i] += tile[i] # add the first row of each tile
    end
  end

  new_rows
end

untiled = []

five_by_25_rows.each do |set|
  set.each do |row|
    untiled << row
  end
end

require 'pry'; binding.pry

matrix = untiled.map.with_index do |row, i|
  row.map.with_index do |cost, j|
    Vertex.new(cost_to_move_to: cost, coords: [i, j])
  end
end

matrix[0][0].minimum_cost = 0

row_count = matrix.length
col_count = matrix.first.length

target = matrix[(row_count - 1)][(col_count - 1)]

find_shortest_path(matrix, target)
