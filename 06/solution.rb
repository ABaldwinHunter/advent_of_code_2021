# Lanternfish
#
# each lantern fish creates a new lanernfish on ce every 7 days

file = "input.txt"
# file = "sample.txt"

fishes = File.read(file).split(",").map(&:to_i)

day_count = 0

new_fish_to_add = 0

while day_count < 80
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
