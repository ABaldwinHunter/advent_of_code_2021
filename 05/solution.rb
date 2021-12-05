# day 5
#
# lines and intersections
#
# brainstorm -
#
# 1) we could find the highest and lowest x and y, and build a grid
# then walk each point and see if there is an intersection
#
# 2) however, maybe it would be a little faster to just identify all of the vertical
# and hhorizontal lines. then check each vertical line to see if a horizontal line crosses it
#
# going to startw with 2 because sounds a little faster
#

# file = 'input.txt'
file = 'sample.txt'

class Line
  attr_reader :start_x, :start_y, :finish_x, :finish_y

  def initialize(line_string)
    start, finish = line_string.split(" -> ")

    x1, y1 = start.split(",").map(&:to_i)
    x2, y2 = finish.split(",").map(&:to_i)

    if x1 == x2
      @start_x = x1
      @finish_x = x2
      @start_y, @finish_y = [y1, y2].sort # to make comparisons easier later
    elsif y1 == y2
      @start_y = y1
      @finish_y = y2
      @start_x, @finish_x = [x1, x2].sort
    else
      @start_x = x1
      @start_y = y1
      @finish_x = x2
      @finish_y = y2
    end
  end

  def vertical?
    start_x == finish_x
  end

  def horizontal?
    start_y == finish_y
  end

  def diagonal?
    !horizontal? && !vertical?
  end

  def ==(line)
    start_x == line.start_x &&
      start_y == line.start_y &&
      finish_x == line.finish_x &&
      finish_y == line.finish_y
  end

  # only for vertical
  def intersection(horizontal_line)
    if intersect?(horizontal_line)
      [start_x, horizontal_line.start_y]
    else
      nil
    end
  end

  def delta_y
    @delta_y = finish_y - start_y
  end

  def delta_x
    @delta_x = finish_x - start_x
  end

  def slope
    @slope ||= delta_y / delta_x.to_f
  end

  def b
    if instance_variable_defined?("@b")
      @b
    else
      @b = if vertical?
             nil
           elsif horizontal?
             start_y
           else
             # y = mx + b
             # start_y = (slope * start_x) + b
             start_y - (slope * start_x)
           end
    end
  end

  def y_equals(x)
    # "y = #{slope}x + b"

    slope * x + b
  end

  def x_equals(y)
    # y = mx + b"
    # y - b = mx
    #
    # (y - b) / m = x
    #
    if slope != 0
      (y - b) / slope
    end
  end

  def include?(point)
    y_range.include?(point.last) && x_range.include?(point.first)
  end

  def find_intersection(line)
    point = find_inifinte_line_intersection(line)

    if include?(point) && line.include?(point)
      point
    else
      [nil, nil]
    end
  end

  def find_inifinte_line_intersection(line) # when line slopes are not same
    result = if line.horizontal?
               [x_equals(line.start_y), line.start_y]
             elsif line.vertical?
               [line.start_x, y_equals(line.start_x)]
             else
               find_diagonal_by_diagonal_intersection(line)
             end

    result
  end

  def to_s
    "#{start_x},#{start_y} => #{finish_x},#{finish_y}"
  end

  # when self is diagonal
  def minimum_requirement_for_intersect?(line)
    if line.vertical?
      (smallest_x <= line.start_x && biggest_x >= line.start_x)
    elsif line.horizontal?
      (smallest_y <= line.start_y && biggest_y >= line.start_y)
    elsif line.diagonal
      y_range.overlaps?(line.y_range) && x_range.overlaps?(line.x_range)
    end
  end

  private

  def find_diagonal_by_diagonal_intersection(line) # assume self and line are both diagonal
    x = (b - line.b) / (line.slope - slope)

    [x, y_equals(x)]
  end

  def y_range
    smallest_y..biggest_y
  end

  def x_range
    smallest_x..biggest_x
  end

  def intersect?(line)
    if vertical? && line.horizontal?
      (start_x >= line.start_x) && (start_x <= line.finish_x) && (line.start_y >= start_y && line.start_y <= finish_y)
    end
  end

  def biggest_x
    @biggest_x ||= [start_x, finish_x].max
  end

  def biggest_y
    @biggest_y ||= [start_y, finish_y].max
  end

  def smallest_x
    @smallest_x ||= [start_x, finish_x].min
  end

  def smallest_y
    @smallest_y ||= [start_y, finish_y].min
  end
end

lines = File.read(file).split("\n").map { |line_string| Line.new(line_string) }

puts "lines"

lines.each do |line|
  puts line.to_s
end

# count intersections
#

vertical_lines = lines.select(&:vertical?)

horizontal_lines = lines.select(&:horizontal?)

intersection_points = []

vertical_lines.each do |v|
  horizontal_lines.each do |h|
    if (point = v.intersection(h))

      puts "inserting point from intersection"
      pp point
      puts "and the vertical line was #{v.to_s}"
      puts "and the horizontal line was #{h.to_s}"
      intersection_points << point
    end
  end
end

# count lines that overlap and are both veritcal or both horizontal

already_counted_vertical = []

vertical_lines.each do |v|
  vertical_lines.each do |v2|
    next unless v.start_x == v2.start_x
    next if (v.finish_y == v2.finish_y) && (v.start_y == v2.start_y)

    key = [[v.start_x, v.start_y], [v2.start_x, v2.start_y]].sort.to_s
    next if already_counted_vertical.include? key

    overlap_start = [v.start_y, v2.start_y].max
    overlap_end = [v.finish_y, v2.finish_y].min

    (overlap_start..overlap_end).each do |num|
      puts "inserting point"
      pp [v.start_x, num]
      intersection_points << [v.start_x, num]
    end

    already_counted_vertical << key
  end
end

already_counted_horizontal = []

horizontal_lines.each do |h|
  horizontal_lines.each do |h2|
    next unless h.start_y == h2.start_y
    next if (h.finish_x == h2.finish_x) && (h.start_x == h2.start_x)

    key = [[h.start_x, h.start_y], [h2.start_x, h2.start_y]].sort.to_s

    puts "key = [[v.start_x, v.start_y], [v2.start_x, v2.start_y]].sort.to_s"

    puts "key"
    pp key

    puts "h1"
    pp h
    puts "h2"
    pp h2
    next if already_counted_horizontal.include? key

    overlap_start = [h.start_x, h2.start_x].max
    overlap_end = [h.finish_x, h2.finish_x].min

    (overlap_start..overlap_end).each do |num|
      puts "inserting point"
      pp [num, h.start_y]
      intersection_points << [num, h.start_y]
    end

    already_counted_horizontal << key
  end
end

puts "already counted vertical"
pp already_counted_vertical

puts "already counted horizontal"
pp already_counted_horizontal

points = intersection_points.uniq.sort

puts "points"

pp points

puts "intersections count is #{points.count}"

# part 2 - include diagonals
#
# iterate over diagonal lines and see if
# any intersect with other diagonal lines
# any intersect with the vertical and horizontal lines

diagonal_lines = lines.select(&:diagonal?)

already_checked_diag = []

puts "vertical lines count = #{vertical_lines.count}"
puts "horizontal lines count = #{horizontal_lines.count}"
puts "diagonal lines count = #{diagonal_lines.count}"

so_far = 0

diagonal_lines.each do |d|
  puts "*"*100
  puts "diag lines so far: #{so_far}/#{diagonal_lines.count}"
  vertical_lines.each do |v|
    next unless d.minimum_requirement_for_intersect?(v)

    point = d.find_intersection(v)

    if point.all? { |num| (num.is_a?(Integer) || num.is_a?(Float)) && ![Float::INFINITY, -Float::INFINITY].include?(num) }
      sup = point.map(&:to_i)

      if sup == [2,6]
        require 'pry'; binding.pry
        points << sup
      else
        points << sup
      end
    end
  end

  horizontal_lines.each do |h|
    next unless d.minimum_requirement_for_intersect?(h)

    point = d.find_intersection(h)

    if point.all? { |num| (num.is_a?(Integer) || num.is_a?(Float)) && ![Float::INFINITY, -Float::INFINITY].include?(num) }
      sup = point.map(&:to_i)

      if sup == [2,6]
        require 'pry'; binding.pry
        points << sup
      else
        points << sup
      end
    end
  end

  diagonal_lines.each do |d2|
    puts "another diag line"
    next if d == d2
    key = [[d.start_x, d.start_y], [d2.start_x, d2.start_y]].sort.to_s

    next if already_checked_diag.include? key

    point = d.find_intersection(d2)

    if point.all? { |num| (num.is_a?(Integer) || num.is_a?(Float)) && ![Float::INFINITY, -Float::INFINITY].include?(num) }
      sup = point.map(&:to_i)

      if sup == [2,6]
        require 'pry'; binding.pry
        points << sup
      else
        points << sup
      end
    end

    already_checked_diag << key
  end

  so_far += 1
end

puts "total points for part 2 = #{points.uniq.count}"

pp points.uniq
