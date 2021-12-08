require 'pry'

# Lanternfish
#
# each lantern fish creates a new lanernfish on ce every 7 days

# # file = "input.txt"
# file = "sample.txt"

# fishes = File.read(file).split(",").map(&:to_i)

# day_count = 0

# new_fish_to_add = 0

# while day_count < 80
#   fishes.each.with_index do |fish, index|
#     if fish == 0
#       fishes[index] = 6
#       new_fish_to_add += 1
#     else
#       fishes[index] = fish - 1
#     end
#   end

#   new_fish_to_add.times do
#     fishes << 8
#   end

#   day_count += 1
#   new_fish_to_add = 0
# end

# puts "total fish count is #{fishes.count}"

file = "input.txt"
# file = "sample.txt"

fishes = File.read(file).split(",").map(&:to_i)
# part 2

start_fish_hash = {
  0 => 0,
  1 => 0,
  2 => 0,
  3 => 0,
  4 => 0,
  5 => 0,
  6 => 0,
  7 => 0,
  8 => 0,
}

fishes.each do |fish|
  if start_fish_hash[fish]
    start_fish_hash[fish] += 1
  else
    start_fish_hash[fish] = 1
  end
end

def evolve(fish_hash, cycles_left)
  if cycles_left == 0
    fish_hash.map { |k, v| v }.compact.sum
  else
    new_fish_hash = {}

    (1..8).each do |fish|
      # 2s in fish hash become 1s in new fish hash
      new_fish_hash[(fish - 1)] = fish_hash[fish]
    end

    new_fish_hash[8] = fish_hash[0]
    new_fish_hash[6] += fish_hash[0]

    evolve(new_fish_hash, (cycles_left - 1))
  end
end

answer = evolve(start_fish_hash, 256)

puts "Answer is #{answer}"
