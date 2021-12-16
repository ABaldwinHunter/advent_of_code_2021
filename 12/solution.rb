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
  small_cave_times_visited = {}

  current_path.each do |cave|
    if small_cave?(cave)
      small_cave_times_visited[cave] ||= 0
      small_cave_times_visited[cave] += 1
    end
  end

  paths = []
  current_cave = current_path.last
  opts = CAVE_TO_CONNECTING_MAP[current_cave]

  opts.each do |next_node|
    skip = false

    if small_cave?(next_node)
      count = small_cave_times_visited[next_node]

      if count
        if count > 1
          skip = true
        elsif small_cave_times_visited.select { |k, v| v > 1 }.map { |pairs| pairs.first }.reject { |cave| cave == next_node }.any? # if any others have been visited twice
          skip = true
        end
      end
    elsif next_node == 'start'
      skip = true
    end

    if skip
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

puts "answer s #{paths.length}"
