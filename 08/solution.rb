# day 8
#
require 'pry'

UNIQ_SEGMENTS_TO_NUMS = {
  2 => 1,
  4 => 4,
  3 => 7,
  7 => 8,
}

# file = 'sample.txt'
file = 'input.txt'

displays = File.read(file).split("\n")

output_thats_1_4_7_or_8 = 0

displays.each do |display|
  output = display.split(" | ").last
  output_nums = output.split(" ").map { |num| num.split("") }

  output_nums.each do|num|
    if UNIQ_SEGMENTS_TO_NUMS.keys.include? num.length
      output_thats_1_4_7_or_8 += 1
    end
  end
end

puts "count is #{output_thats_1_4_7_or_8}"

# part 2
#

class Decoder
  UNIQ_SEGMENTS_TO_NUMS = {
    2 => 1,
    4 => 4,
    3 => 7,
    7 => 8,
  }
  SEGMENT_GROUPS_TO_DIGITS = {
    ["a", "b", "c", "e", "f", "g"] => 0,
    ["c", "f"] => 1,
    ["a", "c", "d", "e", "g"] => 2,
    ["a", "c", "d", "f", "g"] => 3,
    ["b", "c", "d", "f"] => 4,
    ["a", "b", "d", "f", "g"] => 5,
    ["a", "b", "d", "e", "f", "g"] => 6,
    ["a", "c", "f"] => 7,
    ["a", "b", "c" "d", "e", "f", "g"] => 8,
    ["a", "b", "c" "d", "f", "g"] => 9,
  }
  DIGITS_TO_SEGMENT_GROUPS = {
    0 => ["a", "b", "c", "e", "f", "g"],
    1 => ["c", "f"],
    2 => ["a", "c", "d", "e", "g"],
    3 => ["a", "c", "d", "f", "g"],
    4 => ["b", "c", "d", "f"],
    5 => ["a", "b", "d", "f", "g"],
    6 => ["a", "b", "d", "e", "f", "g"],
    7 => ["a", "c", "f"],
    8 => ["a", "b", "c" "d", "e", "f", "g"],
    9 => ["a", "b", "c" "d", "f", "g"],
  }
  DEFAULT_POSSIBILITIES = {
    # where left side is the true number, and right is the coded version
    "a" => ["a", "b", "c", "d", "e", "f", "g"],
    "b" => ["a", "b", "c", "d", "e", "f", "g"],
    "c" => ["a", "b", "c", "d", "e", "f", "g"],
    "d" => ["a", "b", "c", "d", "e", "f", "g"],
    "e" => ["a", "b", "c", "d", "e", "f", "g"],
    "f" => ["a", "b", "c", "d", "e", "f", "g"],
    "g" => ["a", "b", "c", "d", "e", "f", "g"],
  }

  NON_UNIQ_NUMBERS_TO_LENGTHS = {
    2 => 5,
    3 => 5,
    5 => 5,
    6 => 6,
    9 => 6,
  }

  attr_reader :output_nums, :pattern_digits

  def initialize(display)
    pattern, output = display.split(" | ")
    @output_nums = output.split(" ").map { |num| num.split("") }
    # [["a", "b", "c"]]

    @pattern_digits = pattern.split(" ").map { |num| num.split("") }

    # binding.pry
    decode!
  end

  def output_sum
    binding.pry
    output_nums.map { |num| decode(num) }.sum
  end

  def possibilities_map
    @possibilities_map ||= {
      "a" => ["a", "b", "c", "d", "e", "f", "g"],
      "b" => ["a", "b", "c", "d", "e", "f", "g"],
      "c" => ["a", "b", "c", "d", "e", "f", "g"],
      "d" => ["a", "b", "c", "d", "e", "f", "g"],
      "e" => ["a", "b", "c", "d", "e", "f", "g"],
      "f" => ["a", "b", "c", "d", "e", "f", "g"],
      "g" => ["a", "b", "c", "d", "e", "f", "g"],
    }
  end

  private

  def decode!
    while possibilities_map.values.any? { |possibilities| possibilities.count > 1 }
      puts "current possibilities"
      pp possibilities_map

      pattern_digits.each do |coded_digit|
        number_possibilities = Array(deduce_number(coded_digit)) #ensure array

        letter_possibilities = number_possibilities.flat_map { |num| DIGITS_TO_SEGMENT_GROUPS[num] }

        coded_digit.each do |letter|
          current_possibilities = possibilities_map[letter]

          current_possibilities.each do |possibility|
            if !letter_possibilities.include?(possibility)
              # remove because not possible
              possibilities_map[letter].delete(possibility)
            end
          end
        end
      end
    end
  end

  def deduce_number(digit)
    if (number = UNIQ_SEGMENTS_TO_NUMS[digit.length])
      number
    elsif (number = decode(digit))
      number
    else
      length = digit.length

      options = NON_UNIQ_NUMBERS_TO_LENGTHS.select { |k, v| v == length }.keys.reject do |num|
        already_decoded?(num) || !could_be?(digit, num)
      end

      if options.length == 1
        options.first
      else
        options
      end
    end
  end


  def already_decoded?(number)
    DIGITS_TO_SEGMENT_GROUPS[number].all? { |letter| possibilities_map[letter].length == 1 }
  end

  def could_be?(coded_digit, num)
    true_segment_letters = DIGITS_TO_SEGMENT_GROUPS[num]

    fuzzy_letter_groups = coded_digit.map do |letter|
      possibilities_map[letter]
    end

    buckets_could_cover_letters?(fuzzy_letter_groups, true_segment_letters)
  end

  def buckets_could_cover_letters?(possibility_buckets, letters)
    could_be_bucket_map = {}

    letters.each.with_index do |letter, i|
      could_be_bucket_map[i] = []

      possibility_buckets.map.with_index do |bucket, bucket_index|
        if bucket.include? letter
          could_be_bucket_map[i] << bucket_index
        end
      end
    end

    if could_be_bucket_map.any? { |k, v| v.empty? }
      false
    elsif (bucket_values_wth_one = could_be_bucket_map.select { |k, v| v.length == 1 }.map { |k, v| v }).length != bucket_values_wth_one.uniq.length
      false
    # elsif (bucket_values_wth_two = could_be_bucket_map.select { |k, v| v.length == 2 }.map { |k, v| v }).length != (bucket_values_wth_two.uniq.length - 1)
    #   false
    # elsif (bucket_values_wth_three = could_be_bucket_map.select { |k, v| v.length == 3 }.map { |k, v| v }).length != (bucket_values_wth_three.uniq.length - 2)
    #   false
    else
      true
    end
  end

  def decode(coded_digit)
    translated = coded_digit.map do |letter|
      if possibilities_map[letter].count == 1
        possibilities_map[letter].first
      end
    end

    if translated.length == translated.compact.length
      SEGMENT_GROUPS_TO_DIGITS[translated.sort]
    end
  end
end

file = 'sample.txt'
# file = 'input.txt'

displays = File.read(file).split("\n").map { |display| Decoder.new(display) }

answer = displays.sum(&:output_sum)

puts "answer is #{answer}"
