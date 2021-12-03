# part 1 - super naive way
#

# help from + credit to https://www.jakeworth.com/binary-to-decimal-conversion-in-ruby/
class Binary
  def self.to_decimal(binary)
    binary.reverse.map.with_index do |digit, index|
      digit.to_i * 2**index
    end.sum
  end
end

# file = "sample.txt"
file = "input.txt"
binary_numbers = File.read(file).split("\n").map { |num_string| num_string.split("") }

half = binary_numbers.count / 2.0

positions = binary_numbers.first.length

# gamma rate
#

gamma = []
eps = []

(0..(positions - 1)).each do |index|
  numbers_at_position = binary_numbers.map { |number_string| number_string[index] }

  zeros = numbers_at_position.select { |num| num == "0" }.count

  if zeros > half
    common = "0"
    least = "1"
  else
    common = "1"
    least = "0"
  end

  gamma << common
  eps << least
end

puts "gamma rate is #{gamma.join('')}"
puts "epsilon is #{eps.join('')}"

answer = Binary.to_decimal(gamma) * Binary.to_decimal(eps)

puts "Answer is #{answer}"

# part 2
#
# oxygen and scrubber, again most and least common
# but this time filter out numbers each round

# if we converted all of the numbers to binary, we could also do this with modulo
#

def get_rating(current_index, numbers_left, comparator)
  if numbers_left.count == 1
    numbers_left.first # hooray!
  else
    numbers_with_1 = []
    numbers_with_0 = []

    numbers_left.each do |num|
      if num[current_index] == "1"
        numbers_with_1 << num
      else
        numbers_with_0 << num
      end
    end

    new_index = current_index + 1

    new_numbers_left = begin
                         if numbers_with_1.count == numbers_with_0.count
                           if comparator.to_s == '>'
                             numbers_with_1
                           else
                             numbers_with_0
                           end
                         elsif (numbers_with_1.length).send(comparator, numbers_with_0.length)
                           numbers_with_1
                         else
                           numbers_with_0
                         end
                       end

    get_rating(new_index, new_numbers_left, comparator)
  end
end

oxygen = get_rating(0, binary_numbers, :>)
scrubber = get_rating(0, binary_numbers, :<)

puts "oxygen is #{oxygen.join}"
puts "scrubber is #{scrubber.join}"

answer = Binary.to_decimal(oxygen) * Binary.to_decimal(scrubber)

puts "answer for part 2 is #{answer}"

# part 2 another way - using numbers instead of string comparison

def get_rating_v2(current_power_of_2, numbers_left, comparator)
  if numbers_left.count == 1
    numbers_left.first.first # hooray!
  else
    numbers_with_1 = []
    numbers_with_0 = []

    numbers_left.each do |num|
      if (num.last - 2**current_power_of_2) >= 0
        numbers_with_1 << num
      else
        numbers_with_0 << num
      end
    end

    new_numbers_left = begin
                         if numbers_with_1.count == numbers_with_0.count
                           if comparator.to_s == '>'
                             numbers_with_1.map { |tuple| [tuple.first, tuple.last - 2**current_power_of_2] } # preserve original number but cache where we are with power of two calculation
                           else
                             numbers_with_0
                           end
                         elsif (numbers_with_1.length).send(comparator, numbers_with_0.length)
                           numbers_with_1.map { |tuple| [tuple.first, tuple.last - 2**current_power_of_2] } # preserve original number but cache
                         else
                           numbers_with_0
                         end
                       end

    new_power = current_power_of_2 - 1

    get_rating_v2(new_power, new_numbers_left, comparator)
  end
end

biggest_power_of_two = binary_numbers.first.length - 1

decimals = binary_numbers.map { |num| Binary.to_decimal(num) }

decimals_with_amounts_left_after_power_of_two_subtraction = decimals.map { |num| [num, num] }

oxygen = get_rating_v2(biggest_power_of_two, decimals_with_amounts_left_after_power_of_two_subtraction, :>)
scrubber = get_rating_v2(biggest_power_of_two, decimals_with_amounts_left_after_power_of_two_subtraction, :<)

puts "oxygen is #{oxygen}"
puts "scrubber is #{scrubber}"

answer = oxygen * scrubber

puts "answer for part 2 v2 is #{answer}"
