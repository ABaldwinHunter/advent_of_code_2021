def generate_next(tile)
  new = []

  tile.each.with_index do |row, i|
    row.each.with_index do |item, j|
      if item == 9
        new[i] ||= []
        new[i][j] = 1
      else
        new[i] ||= []
        new[i][j] = (item + 1)
      end
    end
  end

  new
end

def build_grid(tile)
  big_grid = []

  tile_length = tile.length

  5.times do
    big_grid << []
  end

  big_grid[0] << tile

  # across the first row
  # then down from each column
  #
  current_tile = tile
  count = 0

  # make the top row
  while count < 4  do
    new_tile = generate_next(current_tile)

    big_grid[0] << new_tile

    current_tile = new_tile

    count += 1
  end

  # make the bottom four rows of tiles

  [1, 2, 3, 4].each do |tile_row|
    new_row_index = 0

    while new_row_index < 5 do
      previous_row = tile_row - 1

      tile = big_grid[previous_row][new_row_index]

      new_tile = generate_next(tile)

      big_grid[tile_row] << new_tile

      new_row_index += 1
    end
  end

  big_grid
end

def build_new_grid(raw_tile)
  tile_length = raw_tile.length
  big_grid = build_grid(raw_tile)

  five_sets_of_full_across_grid_rows = []

  (0..4).each do |tile_row_index|
    tile_row = big_grid[tile_row_index]

    five_sets_of_full_across_grid_rows[tile_row_index] ||= []

    tile_row.each do |tile|
      tile.each.with_index do |row, j|
        five_sets_of_full_across_grid_rows[tile_row_index][j] ||= []
        five_sets_of_full_across_grid_rows[tile_row_index][j] += row
      end
    end
  end

  # require 'pry'; binding.pry

  untiled = []

  five_sets_of_full_across_grid_rows.each do |set|
    set.each do |row|
      untiled << row
    end
  end

  untiled
end


