# day 14
#

file = "sample.txt"
# file = "input.txt"

_template, _rules = File.read(file).split(/\n{2,}/)

template = _template.split("")

template_hash = {}

template.each.with_index do |char, indx|
  template_hash[char] ||= []
  template_hash[char] << indx
end

rules_hash = {}

rules = _rules.split("\n").map do |rule|
  _pair, inserted = rule.split(" -> ")

  pair = _pair.split("")

  rules_hash[pair] = inserted
end

current_step = 1
target = 40
current_template = template_hash
letter_one = template.first
last_letter = template.last # I _think_ this will never change

while current_step <= target
  puts "current step: #{current_step}"
  last_pair_start = (current_template.flat_map { |k, values| values }.max) - 2
  current_new_index_one = 0
  current_new_insertion_index = 1

  new = {}

  (0..(last_pair_start)).each do |index|
    # require 'pry'; binding.pry
    next_index = index + 1

    if letter_one.nil?
      letter_one = current_template.detect do |letter, indices|
        indices.include? index
      end.first
    end

    letter_two = current_template.detect do |letter, indices|
      indices.include? next_index
    end.first

    pair = [letter_one, letter_two]

    insertion = rules_hash[pair]

    new[insertion] ||= []
    new[insertion] << current_new_insertion_index

    new[letter_one] ||= []
    new[letter_one] << current_new_index_one

    letter_one = letter_two
    current_new_index_one += 2
    current_new_insertion_index += 2
  end

  last_element_index = last_pair_start + 1

  new_last_element_index = current_new_index_one # bc of the loop

  new[last_letter] ||= []
  new[last_letter] << new_last_element_index

  current_template = new
  current_step += 1
end

most_occuring = current_template.max_by do |item, values|
  values.count
end.last.count

least = counts.min_by do |item, values|
  values.count
end.last.count

answer = most_occuring - least

puts "answer is #{answer}"
