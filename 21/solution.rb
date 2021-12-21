# game with dice - day 21
#

# ten space track
#
# deterministic die to start, 1-100

def determine_new_position(current_position, roll)
  mod = (current_position + roll) % 10

  if mod == 0
    10
  else
    mod
  end
end

def get_next_die_roll(last)
  if last == 100 || last == 0
    1
  else
    last + 1
  end
end

scores = {
  'player_1' => 0,
  'player_2' => 0,
}

die_rolls = 0
player_1_position = 6 # 4 # sample
player_2_position = 1 # 8 # sample
last_die_roll = 0

while true do
  total_roll = 0

  3.times do
    roll = get_next_die_roll(last_die_roll)
    total_roll += roll
    die_rolls += 1

    last_die_roll = roll
  end

  player_1_position = determine_new_position(player_1_position, total_roll)
  scores['player_1'] += player_1_position

  if scores['player_1'] >= 1000
    break
  end

  # same for player 2

  total_roll = 0

  3.times do
    roll = get_next_die_roll(last_die_roll)
    total_roll += roll
    die_rolls += 1

    last_die_roll = roll
  end

  player_2_position = determine_new_position(player_2_position, total_roll)
  scores['player_2'] += player_2_position

  if scores['player_2'] >= 1000
    break
  end
end

puts "die rolls are #{die_rolls}"
puts "scores are #{scores.values}"
answer = die_rolls * (scores.values.detect { |v| v < 1000 })

puts "answer is #{answer}"


# part 2 - universe
#
# so, even though the die has three possibilities, 1-2-3, and there are 3 rolls, it's really just
# the sum of those three that matters. so the sum possibilities are
# [(111), (112), 113,  122, 123, 133, 222, 223, 233, 333
#
# 3, 4, 5, 5, 6, 7, 6, 7, 7, 8, 9
#
# 3, 4, 5, 6, 7, 8, 9 # possible total die rolls
#
# although maybe still the universe splits each die roll, so maybe that doesn't help
