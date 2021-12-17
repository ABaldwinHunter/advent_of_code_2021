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

TARGET_AREA = {
  'x' => (20..30),
  'y' => (-10..-5),
}

def in_target_area?(x, y)
  TARGET_AREA.fetch('x').include?(x) &&
    TARGET_AREA.fetch('y').include?(y)
end

puts "test"
puts "for # target area: x=20..30, y=-10..-5"

puts "x=25, y=-8 should be true"
puts in_target_area?(25, -8)

puts "x=20, y=--5 should be true"
puts in_target_area?(20, -5)

puts "x=40, y=--5 should be false"
puts in_target_area?(40, -5)
