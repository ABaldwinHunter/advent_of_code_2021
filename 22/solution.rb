# Day 22 - reboot
#

# region to start is -50, -50, -50 to 50, 50, 50
#

ON = []
OFF = []

file = 'sample.txt'

class Instruction
  attr_reader :on, :x_range, :y_range, :z_range
  def initialize(on:, x_range:, y_range:, z_range:)
    @on = on
    @x_range = x_range
    @y_range = y_range
    @z_range = z_range
  end
end

instructions = File.read(file).split("\n").map do |line|
  on, coords = line.split(" ")

  coord_instructions = coords.split(",")
  x = coord_instructions.first.split("x=").last.split("..").map(&:to_i)
  y = coord_instructions.first.split("y=").last.split("..").map(&:to_i)
  z = coord_instructions.first.split("z=").last.split("..").map(&:to_i)

  Instruction.new(on: (on == 'on'), x_range: x, y_range: y, z_range: z)
end

puts instructions.map(&:inspect)
