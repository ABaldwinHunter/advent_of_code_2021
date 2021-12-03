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

file = "sample.txt"
# file = "input.txt"
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

nums = binary_numbers.map { |num| Binary.to_decimal(num) }

# most common

# modulo 2 to the 0th / if they're odd
# modulo 2 to the first / if they're even
# modulo 2 to the second / if they're divisible by 4
# modulo 2 to the third / if they're divisible by 8
#

largest_power = binary_numbers.first.length - 1

def get_rating(current_power, numbers_left, comparator)
  if numbers_left.count <= 1
    numbers_left.first # hooray!
  elsif current_power > 10 || current_power < 0
    [300]
  else
    numbers_with_1 = []
    numbers_with_0 = []

    numbers_left.each do |num|
      if current_power == 0
        if num.odd?
          numbers_with_1 << num
        else
          numbers_with_0 << num
        end
      else
        if ((num % 2**current_power) == 0)
          numbers_with_1 << num
        else
          numbers_with_0 << num
        end
      end
    end

    new_power = current_power - 1

    new_numbers_left = if numbers_with_1 == numbers_with_0
                         numbers_with_1
                       elsif (numbers_with_1.length).send(comparator, numbers_with_0.length)
                         numbers_with_1
                       else
                         numbers_with_0
                       end

    puts "finished a round. numbers left count is #{new_numbers_left.count}"
    pp numbers_left
    puts "new power is #{new_power}"
    get_rating(new_power, new_numbers_left, comparator)
  end
end

oxygen = get_rating(largest_power, nums, :>)
scrubber = get_rating(largest_power, nums, :<)

answer = oxygen * scrubber

puts "answer for part 2 is #{answer}"
