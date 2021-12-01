# part one - count increments
#

depths = File.read("./input.txt").split("\n").map(&:to_i)

increments = 0

last_scan = nil

depths.each do |depth|
  if last_scan && depth > last_scan
    increments += 1
  end

  last_scan = depth
end

puts "increments count is #{increments}"

# part 2
#
# sliding 3 scan window

puts "part 2"

increments = 0

last_window_sum = nil

windows = depths.length

(0..(windows - 1)).each do |index|
  last = index + 2

  next if depths[last].nil?

  window_sum = depths[index..last].sum

  if last_window_sum && window_sum > last_window_sum
    increments += 1
  end

  last_window_sum = window_sum
end

puts "increments count for window scan is #{increments}"
