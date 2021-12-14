# day 14
#

file = "sample.txt"
# file = "input.txt"

_template, _rules = File.read(file).split(/\n{2,}/)

template = _template.split("")

template_hash = {}

template.each.with_index do |char, indx|
  template_hash[indx] = char
end

rules_hash = {}

rules = _rules.split("\n").map do |rule|
  _pair, inserted = rule.split(" -> ")

  pair = _pair.split("")

  rules_hash[pair] = inserted
end

current_step = 1
target = 13
current_template = template_hash

while current_step <= target
  puts current_template.values.join("")
  last_pair_start = current_template.keys.length - 2 # one before the last element
  puts "current step: #{current_step}"
  new_index_one = 0
  new_insertion_index = 1

  new = {}

  (0..(last_pair_start)).each do |index|
    # require 'pry'; binding.pry
    next_index = index + 1

    pair = [current_template[index], current_template[next_index]]
    insertion = rules_hash[pair]

    new[new_index_one] = current_template[index]
    new[new_insertion_index] = insertion

    new_index_one += 2
    new_insertion_index += 2
  end

  last_element_index = last_pair_start + 1

  last_letter = current_template[last_element_index]

  new[new_index_one] = last_letter # it was incremented in last round of loop

  current_template = new
  current_step += 1
end

# require 'pry'; binding.pry

counts = current_template.values.group_by(&:to_s)

most_occuring = counts.max_by do |item, values|
  values.count
end.last.count


least = counts.min_by do |item, values|
  values.count
end.last.count

answer = most_occuring - least

puts "answer is #{answer}"
