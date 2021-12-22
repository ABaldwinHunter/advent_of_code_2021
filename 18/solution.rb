# day 18 snailfish!
# https://en.wikipedia.org/wiki/Snailfish

file = 'sample.txt'
# file = 'input.txt'

# rules
#
# explode nested more than 4 deep
#
# split - 10

require_relative './magnitude.rb'

# first calculate magnitude for one number [DONE]
# then, create reduction function
#

def reduce(snailfish_number)
  # if nested more than 4 deep, explode
  # if > 9, split

  # move from left to right checking

  current_layer = 0

  one = snailfish_number.first

  if one.class == Integer
    next
  else
    one = snailfish_number.first

    if one.class == Integer
      next
    else



end

def nested_more_than_four_deep(snailfish_number)
  if snailfish_number.class == Integer
    false
  else
    one = snailfish_number.first
    two = snailfish_number.last



end
