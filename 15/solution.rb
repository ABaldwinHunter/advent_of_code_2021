# day 15
#
# chitons!
#
# this one is probably going to be so fun and hard because I am very fuzzy and under informed
# about paths, so here we go!
#
# my general initial logic, would be, find all of the paths. then calculate their risk level, and
# choose the smallest
#
# It's a balance between moving few steps and avoid high risk areas

# file = 'input.txt'
file = 'sample.txt'

rows = File.read(file).split("\n").map(&:to_i) # 2d array

num_rows = rows.length
num_cols = rows.first.length

start = [0,0]

destination = [(num_rows - 1), (num_cols - 1)] # moving from top left to bottom right

# how to find all of the potential paths
#
# depth first search
# https://www.geeksforgeeks.org/minimum-cost-of-simple-path-between-two-nodes-in-a-directed-and-weighted-graph/

def minimum_cost_simple_path(point, destination, visited, graph)
  if (point == destination)
    return 0
  end

  visited[point] = 1

  # Traverse through all
  # the adjacent nodes

  ans = Float::INFINITY

  # adjacent = neighbors above, below, left and right

  x = point.first
  y = point.last

  neighbors = [
    [(x + 1), y],
    [(x - 1), y],
    [x, (y + 1)],
    [x, (y - 1)],
  ].reject { |point| point.any? { |coord| coord < 0 } }

  neighbors.each do |neighbor_point|
    if (val = graph[neighbor_point.first] && graph[neighbor_point.first][neighbor_point.last]) && !visited[neighbor_point]
      # Cost of the further path
      curr = minimum_cost_simple_path(neighbor_point, destination, visited, graph)

      # Check if we have reached the destination
      if (curr < Float::INFINITY)

        # Taking the minimum cost path
        ans = [ans, (val + curr)].min

        # Unmarking the current node
        # to make it available for other
        # simple paths
        visited[u] = false

        # Returning the minimum cost
        ans
      end
    end
  end
