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
