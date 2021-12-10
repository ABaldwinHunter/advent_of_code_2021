# day 10
#
require 'pry'

# file = 'sample.txt'
file = 'input.txt'
#

lines = File.read(file).split("\n").map { |line| line.split("") }


POINTS = {
  ')' => 1,
  ']' => 2,
  '}' => 3,
  '>' => 4,
}
# sample should be 26397
#

# plan - the things on the left are like a stack;
# and eventually when we see things on the right, we starting "popping" off the stack
# if something on the right doesn't match the next thing to pop off the stack then illegal
#

PAIRS = {
  "(" => ")",
  "{" => "}",
  "[" => "]",
  "<" => ">",
}

OPENING = PAIRS.keys
CLOSING = PAIRS.values

needs_autocompletions = []

lines.each do |line|
  stack = []
  errored = false

  line.each do |char|
    if OPENING.include? char
      stack << char
    elsif CLOSING.include? char
      latest = stack.pop

      if PAIRS[latest] != char
        errored = true
        break
      end
    end
  end

  if stack.any? && (errored == false)
    needs_autocompletions << stack
  end
end

autocompletions = needs_autocompletions.map do |stack_leftover|
  stack_leftover.reverse.map do |opening_char| # reverse to start from most recent to pop off
    PAIRS.fetch(opening_char)
  end
end

def calculate_score(autocompletion)
  score = 0

  autocompletion.each do |char|
    score = score * 5
    score += POINTS[char]
  end

  score
end

scores = autocompletions.map { |autocompletion| calculate_score(autocompletion) }.sort

middle_index = ((scores.length - 1) / 2) # don't need to readd 1 because index starts at 0

answer = scores[middle_index]

puts "answer is #{answer}"


