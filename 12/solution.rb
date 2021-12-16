# day 12
#
# caves and paths
#
# it feels like this calls for some kind of grid or network

# file = 'sample_one.txt'
# file = 'sample_two.txt'
# file = 'sample_three.txt'
file = 'input.txt'
#
segments = File.read(file).split("\n").map do |seg|
  seg.split("-")
end # ["A", "start"]

# build a hash - easier than segments

CAVE_TO_CONNECTING_MAP = {}

segments.each do |segment|
  first_node = segment.first
  end_node = segment.last

  CAVE_TO_CONNECTING_MAP[first_node] ||= []
  CAVE_TO_CONNECTING_MAP[end_node] ||= []

  CAVE_TO_CONNECTING_MAP[first_node] << end_node
  CAVE_TO_CONNECTING_MAP[end_node] << first_node # both ways
end

# require 'pry'; binding.pry

def small_cave?(cave)
  cave.downcase == cave && !['start', 'end'].include?(cave)
end

def get_paths(current_path)
# require 'pry'; binding.pry
  puts "current path"
  pp current_path

  # exceeded_small_cave_visit_allowance = false
  small_cave_times_visited = {}

  current_path.each do |cave|
    if small_cave?(cave)
      small_cave_times_visited[cave] ||= 0
      small_cave_times_visited[cave] += 1

      if small_cave_times_visited[cave] > 1
        exceeded_small_cave_visit_allowance = true
        puts "greater than once"
      end
    end
  end

  paths = []
  current_cave = current_path.last
  opts = CAVE_TO_CONNECTING_MAP[current_cave]

  opts.each do |next_node|
    if next_node == 'start'
      next
    elsif (count = small_cave_times_visited[next_node]) && count > 0
      next
    else
      new_path = current_path + [next_node]

      if next_node == 'end'
        paths << new_path
      else
        paths += get_paths(new_path)
      end
    end
  end

  paths
end

paths = get_paths(['start'])

pp paths

puts "answer s #{paths.length}"
