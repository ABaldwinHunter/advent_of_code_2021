# day 14
#

# so we don't need the full polymer necessarily, just
# the counts
#
# maybe we can do something with the rules so that they aren't just pair to insertion, but something more. like a function. then we could use recursion

# CH -> B
# [CH] -> [CB, BH]
# [CB] -> [CH, BH]

# file = "sample.txt"
file = "input.txt"

_template, _rules = File.read(file).split(/\n{2,}/)

template = _template.split("")

RULES_HASH = {}

rules = _rules.split("\n").map do |rule|
  _pair, inserted = rule.split(" -> ")

  pair = _pair.split("")

  new_pair_one = [pair.first, inserted]
  new_pair_last = [inserted, pair.last]

  RULES_HASH[pair] = [new_pair_one, new_pair_last]
end

def letter_counts(pair_counts, steps_left)
  # require 'pry'; binding.pry
  # { NH => 6 }
  if steps_left == 0
    pair_counts
  else
    new_pair_counts = {}

    pair_counts.each do |pair, count|
      new_set = RULES_HASH[pair]

      new_set.each do |new_pair|
        new_pair_counts[new_pair] ||= 0
        new_pair_counts[new_pair] += count
      end
    end

    letter_counts(new_pair_counts, (steps_left - 1))
  end
end

last_letter_in_polymer = template.last
starting_pair_counts = {}

last_pair_start = template.length - 2

(0..(last_pair_start)).each do |index|
  next_index = index + 1

  pair = [template[index], template[next_index]]

  starting_pair_counts[pair] ||= 0

  starting_pair_counts[pair] += 1
end

pear_counts = letter_counts(starting_pair_counts, 40)

by_single_letter = {}

pear_counts.each do |pair, count|
  pair.each do |char|
    by_single_letter[char] ||= 0
    by_single_letter[char] += count
  end
end

counts = by_single_letter.values.map do |count|
  # the one that is the last letter will be odd
  #
  if count % 2 == 0
    count / 2
  else
    half = (count - 1) / 2

    half + 1
  end
end

most_occurring = counts.max
least = counts.min

answer = most_occurring - least

puts "answer is #{answer}"
