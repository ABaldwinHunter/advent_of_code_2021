# bingo
#
#
# file = 'sample.txt'
file = 'input.txt'

input = File.read(file).split(/\n{2,}/) # split on blank line

numbers = input.first.split(",").map(&:to_i)

input.shift

# build the boards
# then play
#

boards = input.map do |text_block|
  row_set = text_block.split("\n")

  row_set.map { |row| row.split(" ").map(&:to_i) }
end

puts "boards"
pp boards

# [
#   [22, 13, 17, 11, 0],
#    [8, 2, 23, 4, 24],
#     [21, 9 14 16, 7],
#      [6 10  3 18  5],
#       [1 12 20 15 19],
# ]

def won?(board)
  won_row?(board) || won_col?(board)
end

def won_row?(board)
  board.any? { |row| row.all? { |i| i == 'x' } }
end

def won_col?(board)
  (0..(board.length - 1)).any? do |index|
    board.all? { |row| row[index] == 'x' }
  end
end

def mark_board(board, num)
  board.each do |row|
    row.each.with_index do |row_item, index|
      if num == row_item
        row[index] = 'x'
      end
    end
  end
end

def final_score(board, last_called)
  nums_left = board.flat_map { |row| row.reject { |item| item == 'x' } }
  nums_left.sum * last_called
end

current_index = 0
final_score = nil

while final_score.nil?

  puts "boards"
  pp boards

  num = numbers[current_index]

  boards.each do |board|
    mark_board(board, num)

    if won?(board)
      puts "won!"

      pp board

      final_score = final_score(board, num)
    end
  end

  current_index += 1
end

puts "final score is #{final_score}"
