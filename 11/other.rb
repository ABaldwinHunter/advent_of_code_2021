# day 11
#

file = 'sample.txt'
# file = 'input.txt'
#
rows = File.read(file).split("\n")

class Octopus
  attr_accessor :energy

  def initialize(energy:)
    @energy = energy
  end
end

octopi = rows.map do |row|
  row.split("").map { |num_string| Octopus.new(energy: num_string.to_i)
end # 2d array

current_step = 0

octopi.each do

