# day 14
#
# part one

file = "sample.txt"
# file = "input.txt"

_template, _rules = File.read(file).split(/\n{2,}/)

template = _template.split("")

rules_hash = {}

rules = _rules.split("\n").map do |rule|
  _pair, inserted = rule.split(" -> ")

  pair = _pair.split("")

  rules_hash[pair] = inserted
end

current_step = 1
target = 40
current_template = template

while current_step <= target
  last_pair_start = current_template.length - 2 # one before the last element
  new = []

  (0..(last_pair_start)).each do |index|
    next_index = index + 1
    pair = [current_template[index], current_template[next_index]]
    insertion = rules_hash[pair]

    new << current_template[index]
    new << insertion
  end

  last_element_index = last_pair_start + 1
  new << current_template[last_element_index]

  current_template = new
  current_step += 1
end

counts = current_template.group_by(&:to_s) # "N" -> ["N", "N",]

most_occuring = counts.max_by do |item, values|
  values.count
end.last.count

least = counts.min_by do |item, values|
  values.count
end.last.count

answer = most_occuring - least

puts "answer is #{answer}"
