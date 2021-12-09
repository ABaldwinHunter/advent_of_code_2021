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

  nine_six_and_0 = ten_digits.select { |num| num.length == 6 }

  nine = nine_six_and_0.detect { |num| (num - numbers[4]).length == 2 }

  numbers[9] = nine

  six_and_0 = nine_six_and_0.reject { |num| (num - numbers[4]).length == 2 }

  e = (six_and_0.first - nine).first # both have ee but 9 does not

  six = six_and_0.detect { |num| (numbers[1] - num).length == 1 }
  zero = six_and_0.detect { |num| (numbers[1] - num).length == 0 }

  numbers[6] = six
  numbers[0] = zero

  c = (numbers[1] - six).first

  f = (numbers[1] - [c]).first

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

  output_digits = output.map { |digit| reverse_lookup[digit.sort] }
  output_amount = output_digits.map { |num| num.to_s }.join("").to_i

  total += output_amount
end

puts "output sum of all is #{total}"


