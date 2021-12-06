# Lanternfish
#
# each lantern fish creates a new lanernfish on ce every 7 days

file = "input.txt"
# file = "sample.txt"
# file = "sample_two.txt"

fishes = File.read(file).split(",").map(&:to_i)

day_count = 0

new_fish_to_add = 0

while day_count < 32
  fishes.each.with_index do |fish, index|
    if fish == 0
      fishes[index] = 6
      new_fish_to_add += 1
    else
      fishes[index] = fish - 1
    end
  end

  new_fish_to_add.times do
    fishes << 8
  end

  day_count += 1
  new_fish_to_add = 0
end

puts "total fish count is #{fishes.count}"
pp fishes

# part 2

# AFTER_2_DAYS = {
#   0 => [5, 7],
#   1 => [6, 8],
#   2 => [0],
#   3 => [1],
#   4 => [2],
#   5 => [3],
#   6 => [4],
#   7 => [5],
#   8 => [6],
# }

AFTER_8_DAYS = {
  0 => [6, 1, 8],
  1 => [0, 2],
  2 => [1, 3],
  3 => [2, 4],
  4 => [3, 5],
  5 => [4, 6],
  6 => [5, 7],
  7 => [6, 8],
  8 => [0],
}

# AFTER_80_DAYS = {
#   0 => calculate_fish(0, 10),
#   1 => calculate_fish(1, 10),
#   2 => calculate_fish(2, 10),
#   3 => calculate_fish(3, 10),
#   4 => calculate_fish(4, 10),
#   5 => calculate_fish(5, 10),
#   6 => calculate_fish(6, 10),
#   7 => calculate_fish(7, 10),
#   8 => calculate_fish(8, 10),
# }.freeze

fishes = File.read(file).split(",").map(&:to_i)

def calculate_fish(starting_number, days_as_a_number_of_8s)
  puts "days_as_a_number_of_8s: #{days_as_a_number_of_8s}"
  if days_as_a_number_of_8s == 1
    AFTER_8_DAYS[starting_number]
  else
    AFTER_8_DAYS[starting_number].flat_map { |num| calculate_fish(num, (days_as_a_number_of_8s - 1)) }
  end
end

puts "calulate fish"
# pp calculate_fish(5, 10).count

AFTER_256_DAYS = {
  0 => calculate_fish(0, 32),
  1 => calculate_fish(1, 32),
  2 => calculate_fish(2, 32),
  3 => calculate_fish(3, 32),
  4 => calculate_fish(4, 32),
  5 => calculate_fish(5, 32),
  6 => calculate_fish(6, 32),
  7 => calculate_fish(7, 32),
  8 => calculate_fish(8, 32),
}

total = 0

fishes.each do |fish|
  total += AFTER_256_DAYS[fish].count
end

puts "total is #{total}"
