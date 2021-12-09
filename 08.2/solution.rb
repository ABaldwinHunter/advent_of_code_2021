# day 8 - retry

# identify the numbers
# then deduce from there
#

require 'pry'

# file = 'sample.txt'
file = 'input.txt'

displays = File.read(file).split("\n")

tuples = displays.map { |display| display.split(" | ") }.map do |tuple|
  ten_digits = tuple.first.split(" ").map { |digit| digit.split("") }

  output = tuple.last.split(" ").map { |digit| digit.split("") }

  [ten_digits, output]
end

total = 0

tuples.map do |tuple|
  ten_digits = tuple.first
  output = tuple.last

  numbers = {}

  numbers[1] = ten_digits.detect { |num| num.length == 2 }
  numbers[4] = ten_digits.detect { |num| num.length == 4 }
  numbers[7] = ten_digits.detect { |num| num.length == 3 }
  numbers[8] = ten_digits.detect { |num| num.length == 7 }

  nine_and_six = ten_digits.select { |num| num.length == 6 }

  a =  nine_and_six.first
  b =  nine_and_six.last

  # one has c, and the other has e
  # so the two that don't appear in both are c and e
  #
  c_and_e = [a - b] + [b - a]

  e = (c_and_e - numbers[1]).first.first # includes c and f
  f = (numbers[1] - c_and_e).first
  c = (numbers[1] - [f]).first

  nine = nine_and_six.detect { |num| num.include? c }
  six = nine_and_six.reject { |num| num.include? c }.first

  numbers[9] = nine
  numbers[6] = six

  # a is not in 2
  # b is not in 4 (1, 2, 3, 7)
  # c is solved
  # d is not in three (0, 1, 7)
  # e is solved
  # f is solved
  # g is not 3 (1, 4, 7)


  g_and_d = ["a", "b", "c", "d", "e", "f", "g"].select do |code_letter|
    ten_digits.reject { |digit| digit.include? code_letter }.count == 3
  end

  g = (g_and_d - numbers[4]).first
  d = (g_and_d - [g]).first

  b = ((numbers[4] - numbers[1]) - [d]).first

  a = ["a", "b", "c", "d", "e", "f", "g"].reject { |letter| [b, c, d, e, f, g].include? letter }.first

  decode_possibilities = {
    "a" => a,
    "b" => b,
    "c" => c,
    "d" => d,
    "e" => e,
    "f" => f,
    "g" => g,
  }

  numbers[0] = ["a", "b", "c", "e", "f", "g"].map { |letter| decode_possibilities[letter] }
  numbers[2] = ["a", "c", "d", "e", "g"].map { |letter| decode_possibilities[letter] }
  numbers[3] = ["a", "c", "d", "f", "g"].map { |letter| decode_possibilities[letter] }
  numbers[5] = ["a", "b", "d", "f", "g"].map { |letter| decode_possibilities[letter] }

  reverse_lookup = {}

  numbers.each { |number, letters| reverse_lookup[letters.sort] = number }

  if (probs = output.select { |digit| reverse_lookup[digit.sort].nil? }).any?
    binding.pry
  end

  output_sum = output.map { |digit| reverse_lookup[digit.sort] }.sum

  total += output_sum
end

puts "output sum of all is #{total}"


