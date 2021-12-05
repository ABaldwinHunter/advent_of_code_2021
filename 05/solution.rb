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

file = 'input.txt'
# file = 'sample.txt'

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
    else
      @start_y = y1
      @finish_y = y2
      @start_x, @finish_x = [x1, x2].sort
    end
  end

  def vertical?
    start_x == finish_x
  end

  def horizontal?
    start_y == finish_y
  end

  def intersection(horizontal_line)
    if intersect?(horizontal_line)
      [start_x, horizontal_line.start_y]
    else
      nil
    end
  end

  def to_s
    "#{start_x},#{start_y} => #{finish_x},#{finish_y}"
  end

  private

  def intersect?(line)
    if vertical? && line.horizontal?
      (start_x >= line.start_x) && (start_x <= line.finish_x) && (line.start_y >= start_y && line.start_y <= finish_y)
    end
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
