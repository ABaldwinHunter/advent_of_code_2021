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
  if instruction.first == 'y'
    # horizontal fold
    # x stays the same, y changes, like a mirror

    x, y = coord

    instruction_y = instruction.last

    distance_to_fold = y - instruction_y

    new_y = instruction_y - (distance_to_fold)

    [x, new_y]
  end
end

instruction = instructions.first
dots_to_move = dots.select { |dot| dot.last > instruction.last }
new_dots = dots_to_move.map { |dot| fold(dot, instruction) }

unmoved = dots.reject { |dot| dots_to_move.include? dot }

new_coords = new_dots + unmoved

puts "unique dots are #{new_coords.uniq.count}"
