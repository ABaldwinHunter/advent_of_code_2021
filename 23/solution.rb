# similar to towers of hanoi?
#
##############
#...........#
###D#C#A#B###
  #D#C#B#A#
  #########
#
#
# A up + left 5 - 6
# B up 2, right 1 - 3
# C - 500 * 2
# B - 5
# B - 6
# A - 3
# D 9000s
# A - 9
# A - 2

# eye balling, I think trying to move the As, then the Bs make sense
#
# the minimum D will be is 900 each
# C 500 each
#
#
#
# part 2 - bigger rooms and more amphipods
#
#
##############
#...........#
###D#C#A#B###
# #D#C#B#A#
  #D#B#A#C#
  #D#C#B#A#
  #########
#
#
#
# A - 7 (left) = 7
# B - 3 = 30
# A - 8 = 8
# B - 7 = 70
# C - 7 = 700
# C - 7 = 700
# B - 6 = 60
# C - 8 = 800
# B - 7 (home) = 70
# B - 5 (home) = 50
# B - 5 (home) = 50
# B - 6 (home) = 60
# A - 4 = 4
# C - 8 = 800
# A - 5 = 5
# D - 11 * 4 = 44000
# A - 5 = 5
# A - 6 = 6
# A - 9 = 9
# A - 9 = 9
#
# also too high 47443
#
#
#
#
#
#
# A - 7 (left) = 7
# B - 3 = 30
# A - 8 = 8
# B - 8 = 80
# C - 7 = 700
# C - 7 = 700
# B - 4 = 40
# C - 8 = 800
# B - 5 (home) = 50
# B - 5 (home) = 50
# B - 5 (home) = 50
# B - 6 (home) = 60
# A - 4 = 4
# C - 8 = 800
# A - 5 = 5
# D - 11 * 4 = 44000
# A - 5 = 5
# A - 6 = 6
# A - 9 = 9
# A - 9 = 9
#
# 47413 = toooo high
#
# also not right 47412
