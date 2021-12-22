def magnitude(number)
  if number.class == Integer
    number
  elsif number.class == Array && number.length == 2 && number.all? { |num| num.class == Integer }
    number.first * 3 + number.last * 2
  else
    one = number.first
    two = number.last

    3 * magnitude(one) + 2 * magnitude(two)
  end
end

# testing
#
#
mags = [
  [[1,2],[[3,4],5]], # 143
  [[[[0,7],4],[[7,8],[6,0]]],[8,1]], # 1384
  [[[[1,1],[2,2]],[3,3]],[4,4]], # 445
  [[[[3,0],[5,3]],[4,4]],[5,5]], # 791
  [[[[5,0],[7,4]],[5,5]],[6,6]], # 1137
  [[[[8,7],[7,7]],[[8,6],[7,7]]],[[[0,7],[6,6]],[8,7]]], # 3488
]

# mags.each do |mag|
#   puts magnitude(mag)
# end

