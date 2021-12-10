# day 10
#

# file = 'sample.txt'
file = 'input.txt'
#

lines = File.read(file).split("\n").map { |line| line.split("") }


POINTS = {
  ')' => 3,
  ']' => 57,
  '}' => 1197,
  '>' => 25137,
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

errors = []

lines.each do |line|
  # we only care about the first error
  #

  stack = []

  line.each do |char|
    if OPENING.include? char
      stack << char
    elsif CLOSING.include? char
      latest = stack.pop

      if PAIRS[latest] != char
        errors << char

        break
      end
    end
  end
end

total = errors.map { |char| POINTS.fetch(char) }.sum

puts "total is #{total}"

# autocomplete
#

