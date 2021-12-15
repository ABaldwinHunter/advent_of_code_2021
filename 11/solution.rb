# day 11
#
#
# luminescent octopi
#

require 'pry';

# file = 'sample.txt'
file = 'input.txt'

rows = File.read(file).split("\n").map { |row| row.split("").map(&:to_i) } # 2d array

# [
#  [1, 2, 3, 4]
#  [4, 4, 5, 6]
# ]

def neighbors(coord)
  x = coord.first
  y = coord.last

  neighbors = [
    [(x + 1), y],
    [(x - 1), y],
    [x, (y + 1 )],
    [x, (y - 1 )],
    [(x + 1), (y + 1)],
    [(x - 1), (y + 1)],
    [(x + 1), (y - 1)],
    [(x - 1), (y - 1)],
  ].reject { |set| set.any? { |coord| coord < 0 } } # ruby has a weird thing with negative indices
end

current_step = 1
flashes_count = 0

while current_step <= 100

  puts "step #{current_step}"
  # binding.pry
  flashed_this_step = []

  rows.each.with_index do |row, i|
    row.each.with_index do |octo, j|
      if octo == 9
        flashed_this_step << [i, j]
        flashes_count += 1

        rows[i][j] = 0
      else
        rows[i][j] = octo + 1
      end
    end
  end

  done_flashing = true

  if flashed_this_step.any?
    done_flashing = false
    just_flashed = flashed_this_step
  end

  while done_flashing != true
    new_just_flashed = []

    just_flashed.each do |coord|
      neighbors(coord).each do |c|
        val = (rows[c.first] && rows[c.first][c.last])

        if val && val != 0 # there's a neighbor and it didn't flash this step
          if val == 9
            # flash
            flashes_count += 1
            rows[c.first][c.last] = 0

            new_just_flashed << [c.first, c.last]
          else
            rows[c.first][c.last] = (val + 1)
          end
        end

      end
    end

    if new_just_flashed.any?
      just_flashed = new_just_flashed
    else
      done_flashing = true
    end
  end

  current_step += 1

end

puts "answer is #{flashes_count}"

# 202 is too low
