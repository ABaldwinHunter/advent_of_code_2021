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

  def intersect?(line)
    if vertical? && line.horizontal?
      (start_x > line.start_x) && (start_x < line.finish_x)
    end
  end
end

lines = File.read(file).split("\n").map { |line_string| Line.new(line_string) }

# count intersections
#

vertical_lines = lines.select(&:vertical?)

horizontal_lines = lines.select(&:horizontal?)

intersections_count = 0

vertical_lines.each do |v|
  horizontal_lines.each do |h|
    if v.intersect?(h)
      intersections_count += 1
    end
  end
end

# count lines that overlap and are both veritcal or both horizontal

already_counted = []

vertical_lines.each do |v|
  vertical_lines.each do |v2|
    next unless v.start_x == v2.start_x

    key = [[v.start_x, v.start_y], [v2.start_x, v2.start_y]].sort.to_s
    next if already_counted.include? key

    overlap_start = [v.start_y, v2.start_y].max
    overlap_end = [v.finish_y, v2.finish_y].min

    points = overlap_end - overlap_start

    intersections_count += points

    already_counted << key
  end
end

horizontal_lines.each do |h|
  horizontal_lines.each do |h2|
    next unless h.start_y == h2.start_y

    key = [[h.start_x, h.start_y], [h2.start_x, h2.start_y]].sort.to_s
    next if already_counted.include? key

    overlap_start = [h.start_x, h2.start_x].max
    overlap_end = [h.finish_x, h2.finish_x].min

    points = overlap_end - overlap_start

    intersections_count += points

    already_counted << key
  end
end

puts "intersections count is #{intersections_count}"
