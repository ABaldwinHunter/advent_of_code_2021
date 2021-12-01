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

