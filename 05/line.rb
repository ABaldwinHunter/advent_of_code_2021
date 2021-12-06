class Line
  attr_reader :start_x, :start_y, :finish_x, :finish_y

  def initialize(line_string)
    start, finish = line_string.split(" -> ")

    x1, y1 = start.split(",").map(&:to_i)
    x2, y2 = finish.split(",").map(&:to_i)

    if x1 == x2
      @start_x = x1
      @finish_x = x2
      @start_y, @finish_y = [y1, y2].sort # to make comparisons easier later
    elsif y1 == y2
      @start_y = y1
      @finish_y = y2
      @start_x, @finish_x = [x1, x2].sort
    else
      @start_x = x1
      @start_y = y1
      @finish_x = x2
      @finish_y = y2
    end
  end

  def vertical?
    start_x == finish_x
  end

  def horizontal?
    start_y == finish_y
  end

  def diagonal?
    !horizontal? && !vertical?
  end

  def ==(line)
    to_s == line.to_s
  end

  # only for vertical
  def intersection(horizontal_line)
    if intersect?(horizontal_line)
      [start_x, horizontal_line.start_y]
    else
      nil
    end
  end

  def delta_y
    @delta_y = finish_y - start_y
  end

  def delta_x
    @delta_x = finish_x - start_x
  end

  def slope
    @slope ||= delta_y / delta_x.to_f
  end

  def b
    if instance_variable_defined?("@b")
      @b
    else
      @b = if vertical?
             nil
           elsif horizontal?
             start_y
           else
             # y = mx + b
             # start_y = (slope * start_x) + b
             start_y - (slope * start_x)
           end
    end
  end

  def y_equals(x)
    # "y = #{slope}x + b"

    slope * x + b
  end

  def x_equals(y)
    # y = mx + b"
    # y - b = mx
    #
    # (y - b) / m = x
    #
    (y - b) / slope.to_f
  end

  def include?(point)
    y_range.include?(point.last) && x_range.include?(point.first)
  end

  def find_intersection(line)
    point = find_inifinte_line_intersection(line)

    if include?(point) && line.include?(point)
      point
    else
      [nil, nil]
    end
  end

  def find_inifinte_line_intersection(line) # when line slopes are not same
    result = if line.horizontal?
               [x_equals(line.start_y), line.start_y]
             elsif line.vertical?
               [line.start_x, y_equals(line.start_x)]
             else
               find_diagonal_by_diagonal_intersection(line)
             end

    result
  end

  def to_s
    "#{start_x},#{start_y} => #{finish_x},#{finish_y}"
  end

  # when self is diagonal
  def minimum_requirement_for_intersect?(line)
    if line.vertical?
      (smallest_x <= line.start_x && biggest_x >= line.start_x)
    elsif line.horizontal?
      (smallest_y <= line.start_y && biggest_y >= line.start_y)
    elsif line.diagonal?
      (y_range.cover?(line.smallest_y) || y_range.cover?(line.biggest_y)) &&
        (x_range.cover?(line.smallest_x) || x_range.cover?(line.biggest_x))
    end
  end

  def find_overlapping_diagonal_points(line)
    overlapping_x_points = x_range.select { |x| line.x_range.member?(x) }

    overlapping_x_points.map do |x|
      [x, y_equals(x)].map(&:to_i)
    end
  end

  def x_range
    ((smallest_x)..(biggest_x))
  end

  def y_range
    ((smallest_y)..(biggest_y))
  end

  def biggest_x
    @biggest_x ||= [start_x, finish_x].max
  end

  def biggest_y
    @biggest_y ||= [start_y, finish_y].max
  end

  def smallest_x
    @smallest_x ||= [start_x, finish_x].min
  end

  def smallest_y
    @smallest_y ||= [start_y, finish_y].min
  end

  private

  def find_diagonal_by_diagonal_intersection(line) # assume self and line are both diagonal
    x = (b - line.b) / (line.slope - slope)

    [x, y_equals(x)]
  end

  def intersect?(line)
    if vertical? && line.horizontal?
      (start_x >= line.start_x) && (start_x <= line.finish_x) && (line.start_y >= start_y && line.start_y <= finish_y)
    end
  end
end
