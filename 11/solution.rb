# day 11
#
#
# luminescent octopi
#

require 'pry';

file = 'sample.txt'
# file = 'input.txt'

octos = File.read(file).split("\n").map { |row| row.split("").map(&:to_i) } # 2d array

def zero_neighbors(coord, rows)
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
  ].select do |neighbor_coord|
    value = (rows[neighbor_coord.first] && rows[neighbor_coord.first][neighbor_coord.last])

    value && value == 0
  end.compact
end

current_step = 1
flashes_count = 0
flashed_on_step = {}

while current_step <= 10
  puts "step #{current_step}"
  unchanged_for_one_round = false
  current_round = 1
  flashed_on_round = {}
  last_state = nil

  while (unchanged_for_one_round == false) do
    binding.pry
    puts "round #{current_round}"

    octos.each.with_index do |row, i|
      row.each.with_index do |octo, j|
        if (octo == 0 && flashed_on_step[(current_step)]&.include?([i, j]))
            # do nothing
        else
          luminescent_neighbors = zero_neighbors([i, j], octos).select { |coord| flashed_on_round[(current_round - 1)]&.include?(coord) }

          luminescent_neighbors.each do |neighbor|
            octo += 1
          end

          if current_round == 1
            octo += 1
          end

          if octo >= 10
            flashed_on_round[current_round] ||= []
            flashed_on_round[current_round] << [i, j]
            flashes_count += 1

            octo = 0
          end

          octos[i][j] = octo
        end
      end
    end

    unless last_state.nil?
      if octos == last_state
        unchanged_for_one_round = true
      end
    end

    last_state = octos
    current_round += 1
  end
end

current_step += 1

puts "answer is #{flashes_count}"

