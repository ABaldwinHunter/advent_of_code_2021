# day 17 - launching
#
# rules:
#
# initial x,y position is 0,0
#
# for velocity x y, x describes the horizontal movement, y the vertical
#
# there is drag - absolute value of x decreases each step
#
# there is gravity - value of y decreases each step
#
#

# velocity
#
# position
#
# I think velocity is the change in position
#
# oh and there's a target
#
# target area: x=111..161, y=-154..-101
#

# TARGET_AREA = {
#   x: (111..161),
#   y: (-154..-101),
# }

# sample
#
# target area: x=20..30, y=-10..-5
#
#
# puts "test"
# puts "for # target area: x=20..30, y=-10..-5"

# puts "x=25, y=-8 should be true"
# puts in_target_area?(25, -8)

# puts "x=20, y=--5 should be true"
# puts in_target_area?(20, -5)

# puts "x=40, y=--5 should be false"
# puts in_target_area?(40, -5)

TARGET_AREA = {
  'x' => (20..30),
  'y' => (-10..-5),
}

def in_target_area?(x, y)
  TARGET_AREA.fetch('x').include?(x) &&
    TARGET_AREA.fetch('y').include?(y)
end

# we want to find the starting velocity to increase the y position
# the shape will be like an upside down parabola I think
#
# we could just keep increasing one or both x and y and keep track of the highest position
# but let's do a couple by hand
#
# 6,9 was the best for the other
#
# well we probably want to get as far to the right of the space as possible
#
# basically the smallest x such that it still hits the spot

# every step the x decreases by one
#

def addition_factorial(number)
  sum = 0

  while number > 0
    sum += number
    number -= 1
  end

  sum
end

def min_starting_x_for_distance(horizontal_distance) # assuming position 0 and y infinitely high
  puts "beginning"
  # each step the x slows down by one
  # our problem doesn't really care about negative x - though maybe that's next

  # start with lowest and then stop when reached
  # x + (x - 1) + (x - 2) + (x - 3) + (x - 4)
  min_starting_x_velocity = 1
  found = false
  candidate = nil

  while !found
    candidate = addition_factorial(min_starting_x_velocity)
    puts "candidate is #{candidate}"
    if candidate >= horizontal_distance
      candidate
      found = true
    else
      min_starting_x_velocity += 1
    end
  end

  min_starting_x_velocity
end

# puts min_starting_x_for_distance(20) # confirm 6

# the horizontal distance traveled is the bottom of a triangle
#
# a^2 + b^2 = c^2 # pythagoraean theorem
#

puts min_starting_x_for_distance(111)

