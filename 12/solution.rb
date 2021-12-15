# day 12
#
# caves and paths
#
# it feels like this calls for some kind of grid or network

file = 'sample_one.txt'
# file = 'sample_two.txt'
# file = 'sample_three.txt'
# file = 'input.txt'
#
segments = File.read(file).split("\n").map do |seg|
  seg.split("-")
end # ["A", "start"]

segments_with_start = segments.select { |seg| seg.any? == 'start' }
segments_with_end = segments.select { |seg| seg.any? == 'end' }

# build paths iteratively, starting from segments with start

valid_paths = []

segments_with_start.each do |segment|
  first_cave = segment.select { |spot| spot != 'start' }.first

  segments_with_first_cave = segments.select { |seg| seg.include? first_cave }
end

class Node
  attr_reader :value

  def initialize(value:, connections:)
    @value = value
    @connections = connections
  end

  def big?
    (value.upcase == value)
  end

  def small?
    !big?
  end

  def start?
    value == 'start'
  end

  def end_node?
    value == 'end'
  end

  def connections
  end
end

class Network
  def initialize(segments)
    @segments = segments

    build_nodes(segment)
  end

  def build_nodes
    caves = []



  end
end

