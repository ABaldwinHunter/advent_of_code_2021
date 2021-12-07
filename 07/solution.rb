# crabs and fuel
#

file = 'input.txt'
# file = 'sample.txt'

positions = File.read(file).split(",").map(&:to_i)

positions_map = {}

positions.uniq.each do |position|
  positions_map[position] = 0
end

positions_map.keys.each do |k|
  total_cost = 0

  positions.each do |position|
    total_cost += (position - k).abs
  end

  positions_map[k] = total_cost
end

tuples = positions_map.map { |k, v| [k, v] }

tiniest = tuples.min_by { |tuple| tuple.last }

puts "smallest is #{tiniest.last}"

# part 2

checks = {}

min_position = positions.uniq.min
max_position = positions.uniq.max

(min_position..max_position).each do |position|
  positions_map[position] = 0
end

positions_map.keys.each do |k|
  total_cost = 0

  positions.each do |position|
    steps = (position - k).abs
    cost_per_step = 1

    while cost_per_step <= steps
      total_cost += cost_per_step
      cost_per_step += 1
    end
  end

  positions_map[k] = total_cost
end

tuples = positions_map.map { |k, v| [k, v] }

tiniest = tuples.min_by { |tuple| tuple.last }

puts "part 2 smallest is #{tiniest.last}"

# pp tuples
# guess 92881138
92881128
