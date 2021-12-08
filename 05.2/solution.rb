# day 5 - do-over

# counting vertical lines only
#

class Line
  attr_reader :start_point, :end_point

  def initialize(start_point, end_point)
    @start_point = start_point
    @end_point = end_point
  end

  def x1
    @x1 ||= start_point.first
  end

  def y1
    @y1 ||= start_point.last
  end

  def x2
    @x2 ||= end_point.first
  end

  def y2
    @y2 ||= end_point.last
  end

  def vertical?
    x1 == x2
  end

  def horizontal?
    y1 == y2
  end

  def x_decreasing?
    x1 > x2
  end

  def y_decreasing?
    y1 > y2
  end

  def diagonal?
    !vertical && !horizontal
  end

  def points
    if vertical?
      Array(y1..y2).map { |y| [x1, y] }
    elsif horizontal?
      Array(x1..x2).map { |x| [x, y1] }
    else
      _points = []

      current_x = x1
      current_y = y1

      while current_x != x2
        _points << [current_x, current_y]

        if x_decreasing?
          current_x -= 1
        else
          current_x += 1
        end

        if y_decreasing?
          current_y -= 1
        else
          current_y += 1
        end
      end
      _points
    end
  end
end

file = "sample.txt"
# file = "input.txt"

point_sets = File.read(file).split("\n").map do |point_set_string|
  point_set_string.split(" -> ").map do |coordinates|
    coordinates.split(",").map(&:to_i) # [3,4]
  end
end

lines = point_sets.map { |point_set| Line.new(point_set.first, point_set.last) }

part_one_lines = lines.select { |line| line.vertical? || line.horizontal? }

points_map = {}

require 'pry'; binding.pry

part_one_lines.each do |line|
  line.points.each do |point|
    if (current_value = points_map[point])
      points_map[point] = (current_value + 1)
    else
      points_map[point] = 1
    end
  end
end

points_with_intersection = points_map.select { |k,v| v > 1 }

puts "points with intersection"

puts points_with_intersection.count

pp points_with_intersection

pp points_map
