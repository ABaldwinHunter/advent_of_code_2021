# Day 13
# origami dots
#

# first create all the coordinates
# then adjust their positions after
# de-dupe on uniqueness and that should be the number
# we can probably do transformations on the y and x without
# constructing an entire grid or something
#

file= 'input.txt'
# file = 'sample.txt'

dots, instructions = File.read(file).split(/\n{2,}/)

dots = dots.split("\n").map do |dot|
  dot.split(",").map(&:to_i)
end

instructions = instructions.split("\n").map do |instruction|
  line = instruction.split("fold along ").last

  line = line.split("=")

  line = [line.first, line.last.to_i]
end

# part 1
#
# only use first fold
#

# first_fold y=7
#

before = dots.count

puts "before fold #{before} dots are visible"

def fold(coord, instruction)
  x, y = coord
  axis = instruction.first
  number = instruction.last

  if axis == 'y'
    # horizontal fold
    # x stays the same, y changes, like a mirror

    distance_to_fold = y - number

    new_y = number - (distance_to_fold)

    [x, new_y]
  elsif axis == 'x'
    # vertical fold
    # y stays the same, x changes, like a mirror
    #

    distance_to_fold = x - number

    new_x = number - distance_to_fold

    [new_x, y]
  end
end

instruction = instructions.first

# # if y
# dots_to_move = dots.select { |dot| dot.last > instruction.last }

# if x
dots_to_move = dots.select { |dot| dot.first > instruction.last }

new_dots = dots_to_move.map { |dot| fold(dot, instruction) }
unmoved = dots.reject { |dot| dots_to_move.include? dot }
new_coords = new_dots + unmoved

puts "unique dots are #{new_coords.uniq.count}"

# 736 is too low
