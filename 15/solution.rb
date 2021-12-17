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

def neighbors(matrix, x, y)
  coords = [
    [(x + 1), y],
    [(x - 1), y],
    [x, (y + 1)],
    [x, (y - 1)],
  ].reject { |point| point.any? { |coord| coord < 0 } } # ruby array -1 returns something

  coords.select do |coord|
    matrix[coord.first] && matrix[coord.first][coord.last]
  end
end

class Vertex
  attr_reader :cost_to_move_to
  attr_accessor :visited, :minimum_cost

  def initialize(cost_to_move_to:, minimum_cost: Float::INFINITY)
    @cost_to_move_to = cost_to_move_to
    @visited = false
    # @shortest_cost_to_get_to_from_source
    @minimum_cost = minimum_cost
  end

  def visited?
    @visited
  end

  def to_s
    "vertex with cost #{cost_to_move_to}, minimum_path_cost #{minimum_cost}"
  end
end

matrix = File.read(file).split("\n").map do |row|
  row.split("").map { |str_cost| Vertex.new(cost_to_move_to: str_cost.to_i) }
end

matrix[0][0].minimum_cost = 0
matrix[0][0].visited = true

# implement heap sort

puts matrix.map { |row| row.map(&:to_s).join(" ") }.join("\n")

def dijkstra(from_position, to_position, matrix) # marking visited on the vertices themselves
  # we're doing breadth first queue

  queue = []

  current_vertex = from_position

  while current_vertex != to_position do
    neighbor_coords = neighbors(matrix, current_vertex.first, current_vertex.last)

    # compare risk from the current vertex to the neighbor to what neighbor already has as min
    #

    curr_min_cost = matrix[current_vertex.first][current_vertex.last].minimum_cost

    neighbor_coords.each do |neighbor_vertex|
      vertex_obj = matrix[neighbor_vertex.first][neighbor_vertex.last]

      new_cost = curr_min_cost + vertex_obj.cost_to_move_to

      if vertex_obj.minimum_cost > new_cost
        vertex_obj.minimum_cost = new_cost
      end

      if !vertex_obj.visted?
        queue << neighbor_vertex
      end
    end
  end
end
