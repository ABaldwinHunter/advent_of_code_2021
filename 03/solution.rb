# part 1 - super naive way
#

binary_numbers = File.read("input.txt").split("\n").map { |num_string| num_string.split("") }

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

class Binary
  def self.to_decimal(binary)
    binary.reverse.map.with_index do |digit, index|
      digit.to_i * 2**index
    end.sum
  end
end

answer = Binary.to_decimal(gamma) * Binary.to_decimal(eps)

puts "Answer is #{answer}"


