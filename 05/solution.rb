# day 5
#
# lines and intersections
#
require_relative './line.rb'

file = 'input.txt'
# file = 'sample.txt'
# file = 'sample_two.txt'

lines = File.read(file).split("\n").map { |line_string| Line.new(line_string) }

puts "lines"

lines.each do |line|
  puts line.to_s
end

# count intersections

vertical_lines = lines.select(&:vertical?)
horizontal_lines = lines.select(&:horizontal?)
intersection_points = []

vertical_lines.each do |v|
  horizontal_lines.each do |h|
    if (point = v.intersection(h))
      intersection_points << point
    end
  end
end

# count lines that overlap and are both veritcal or both horizontal

already_counted_vertical = []

vertical_lines.each do |v|
  vertical_lines.each do |v2|
    next unless v.start_x == v2.start_x
    next if v == v2

    key = [[v.start_x, v.start_y], [v2.start_x, v2.start_y]].sort.to_s
    next if already_counted_vertical.include? key

    overlap_start = [v.start_y, v2.start_y].max
    overlap_end = [v.finish_y, v2.finish_y].min

    (overlap_start..overlap_end).each do |num|
      intersection_points << [v.start_x, num]
    end

    already_counted_vertical << key
  end
end

already_counted_horizontal = []

horizontal_lines.each do |h|
  horizontal_lines.each do |h2|
    next unless h.start_y == h2.start_y
    next if h == h2

    key = [[h.start_x, h.start_y], [h2.start_x, h2.start_y]].sort.to_s

    next if already_counted_horizontal.include? key

    overlap_start = [h.start_x, h2.start_x].max
    overlap_end = [h.finish_x, h2.finish_x].min

    (overlap_start..overlap_end).each do |num|
      intersection_points << [num, h.start_y]
    end

    already_counted_horizontal << key
  end
end

points = intersection_points.uniq

puts "points"

pp points

puts "intersections count is #{points.count}"

# part 2 - include diagonals
#
diagonal_lines = lines.select(&:diagonal?)

diagonal_lines.each do |d|
  print "*"
  vertical_lines.each do |v|
    point = d.find_intersection(v)

    if point.all? { |num| (num.is_a?(Integer) || num.is_a?(Float)) && ![Float::INFINITY, -Float::INFINITY].include?(num) }
      sup = point.map(&:to_i)

      points << sup
    end
  end

  horizontal_lines.each do |h|
    point = d.find_intersection(h)

    if point.all? { |num| (num.is_a?(Integer) || num.is_a?(Float)) && ![Float::INFINITY, -Float::INFINITY].include?(num) }
      sup = point.map(&:to_i)

      points << sup
    end
  end

  diagonal_lines.each do |d2|
    next if d == d2

    if (d.slope == d2.slope) && d.b == d2.b
      puts "*"*100
      puts "same slope and b"
      pp d
      pp d2

      overlap = d.find_overlapping_diagonal_points(d2)

      puts "overlap"
      pp overlap

      points += overlap
    else
      point = d.find_intersection(d2)

      if point.all? { |num| (num.is_a?(Integer) || num.is_a?(Float)) && ![Float::INFINITY, -Float::INFINITY].include?(num) }
        sup = point.map(&:to_i)

        points << sup
      end
    end
  end
end

# 92,283
#
# recent guess 24,236

# recent guess 23368

puts "total points for part 2 = #{points.uniq.count}"
