# day 8
#

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

