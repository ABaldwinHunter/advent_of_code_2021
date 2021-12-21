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

