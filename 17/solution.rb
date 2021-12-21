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

TARGET_AREA = {
  'x' => (111..161),
  'y' => (-154..-101),
}

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

# TARGET_AREA = {
#   'x' => (20..30),
#   'y' => (-10..-5),
# }

def in_target_area?(x, y)
  TARGET_AREA.fetch('x').include?(x) &&
    TARGET_AREA.fetch('y').include?(y)
end

def past_target_area?(x, y)
  (x > TARGET_AREA.fetch('x').max) || (y < TARGET_AREA.fetch('y').min)
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

puts min_starting_x_for_distance(111) # 15

# and now we try to find the max y

# x has to be 0 as y falls straight down

# sample, we know is 6, 9

# there will be at least 15 steps

# def y_start_for_steps_and_target_min(15, -101) # has to be at least this low
# end

def lands_in_target?(x_velocity, y_velocity)
  x_position = 0
  y_position = 0
  highest_y_position = 0

  finished = false
  lands_in_target = nil

  while !finished do
    puts "x_position, y_position, #{x_position}, #{y_position}"
    x_position += x_velocity
    y_position += y_velocity

    if y_position > highest_y_position
      highest_y_position = y_position
    end

    if x_velocity > 0
      x_velocity -= 1
    end

    y_velocity -= 1

    if in_target_area?(x_position, y_position)
      lands_in_target = true
      puts "highest y position is #{highest_y_position}"
      finished = true
    elsif past_target_area?(x_position, y_position)
      puts "past target area for y velocity #{y_velocity}"
      lands_in_target = false
      finished = true
    end
  end

  lands_in_target
end

def check_for_ys(x_velocity, max_y = 153)
  test_y = max_y
  found_it = false

  while (!found_it && test_y > 0) do
    puts "testing"
    if lands_in_target?(x_velocity, test_y)
      found_it = true
    else
      test_y -= 1
    end
  end

  test_y
end

# puts check_for_ys(15) # 153 PART ONE
# x was the minimum x
# highest y position 11781

# part 2
#
# I think I want to do something similar, but this time find the max x

puts min_starting_x_for_distance(161) # 18

# check all of the y possibilities for x between 16 and 18
#

def check_for_all_ys(x_velocity, max_y, min_y)
  max = max_y
  min = min_y
  ys = []

  test_y = max

  while (test_y > min) do
    puts "testing"
    if lands_in_target?(x_velocity, test_y)
      ys << test_y
    else
      test_y -= 1
    end
  end

  ys
end

velocities = [[15, 153]]

latest_min_y = -308
latest_max_y = 153

(16..164).each do |start_x|
  max_y = check_for_ys(start_x, latest_max_y)

  check_for_all_ys(start_x, max_y, latest_min_y).map do |y|
    velocities << [start_x, y]
  end
end

puts "count is"
puts "#{velocities.uniq.count}"

# no the max x could be 164


