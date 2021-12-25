# christmas
# sea cucumbers
#
# find first day when none move
#

# first model the positions
# then model the movements
# count number moved during a step (a step has
# two phases, east then south)
# record when first time none move
#

file = 'input.txt'
# file = 'sample.txt'

board = File.read(file).split("\n").map do |row|
  row.split("")
end

step = 0
moved_this_step = nil
MOST_EAST_INDEX = board.first.length - 1
MOST_SOUTH_INDEX = board.length - 1

def next_east_coordinates(i, j)
  if j == MOST_EAST_INDEX
    [i, 0]
  else
    [i, (j + 1)]
  end
end

def next_south_coordinates(i, j)
  if i == MOST_SOUTH_INDEX
    [0, j]
  else
    [(i + 1), j]
  end
end

while moved_this_step != 0 do
  moved_this_step = nil
  step += 1

  puts "on step"

  should_become_dots = []
  should_become_east_cucumbers = []

  board.each.with_index do |row, i|
    row.each.with_index do |sea_cucumber, j|
      if sea_cucumber == '>'
        target = next_east_coordinates(i, j)

        if board[target.first][target.last] == '.'
          should_become_east_cucumbers << target
          should_become_dots << [i, j]

          moved_this_step ||= 0
          moved_this_step += 1
        end
      end
    end
  end

  should_become_east_cucumbers.each do |coord|
    board[coord.first][coord.last] = '>'
  end

  should_become_dots.each do |coord|
    board[coord.first][coord.last] = '.'
  end

  should_become_dots = []
  should_become_south_cucumbers = []

  board.each.with_index do |row, i|
    row.each.with_index do |sea_cucumber, j|
      if sea_cucumber == 'v'
        target = next_south_coordinates(i, j)

        if board[target.first][target.last] == '.'
          should_become_south_cucumbers << target
          should_become_dots << [i, j]

          moved_this_step ||= 0
          moved_this_step += 1
        end
      end
    end
  end

  should_become_south_cucumbers.each do |coord|
    board[coord.first][coord.last] = 'v'
  end

  should_become_dots.each do |coord|
    board[coord.first][coord.last] = '.'
  end

  if moved_this_step.nil?
    moved_this_step = 0
  end
end

puts "first step none moved is #{step}"
