# part 1
#

instructions = File.read("input.txt").split("\n")

depth = 0
horizontal = 0

instructions.each do |instruction|
  direction, number = instruction.split(" ")

  number = number.to_i

  case direction
  when "forward"
    horizontal += number
  when "down"
    depth += number
  when "up"
    depth -= number
  end
end

puts "depth is #{depth}. horizontal is #{horizontal}. product is:"

puts horizontal * depth

# part 2
#

depth = 0
horizontal = 0
aim = 0

instructions.each do |instruction|
  direction, number = instruction.split(" ")

  number = number.to_i

  case direction
  when "forward"
    depth += (aim * number)
    horizontal += number
  when "down"
    aim += number
  when "up"
    aim -= number
  end
end

puts "depth is #{depth}. horizontal is #{horizontal}. product is:"

puts horizontal * depth
