module Day11
  module_function

  def parse(raw_input); end

  def adjacent_seats(row, col, grid)
    adjacent_seats = []
    total_cols = grid.first.length
    total_rows = grid.length

    [
      [-1, -1],
      [-1, 0],
      [-1, 1],
      [0, -1],
      [0, 1],
      [1, -1],
      [1, 0],
      [1, 1]
    ].each do |row_diff, col_diff|
      if (row + row_diff).between?(0, total_rows - 1) &&
         (col + col_diff).between?(0, total_cols - 1)
        adjacent_seats << grid[row + row_diff][col + col_diff]
      end
    end

    adjacent_seats
  end

  FLOOR = '.'.freeze
  OCCUPIED = '#'.freeze
  EMPTY = 'L'.freeze
  def arrange_occupants(input)
    grid = input.split("\n").map { |line| line.split('') }

    is_final_arrangement = false
    until is_final_arrangement
      is_final_arrangement = true
      new_grid = grid.map(&:dup)

      grid.each_with_index do |row_array, row|
        row_array.each_with_index do |cell, col|
          next if cell == FLOOR

          occupied_seats = adjacent_seats(row, col, grid).count('#')
          if cell == EMPTY && occupied_seats.zero?
            new_grid[row][col] = OCCUPIED
            is_final_arrangement = false
          end

          if cell == OCCUPIED && occupied_seats >= 4
            new_grid[row][col] = EMPTY
            is_final_arrangement = false
          end
        end
      end
      grid = new_grid
    end

    grid.flatten.count('#')
  end

  def nearest_seats_in_all_directions(row, col, grid)
    nearest_seats = []
    total_cols = grid.first.length
    total_rows = grid.length

    [
      [-1, -1],
      [-1, 0],
      [-1, 1],
      [0, -1],
      [0, 1],
      [1, -1],
      [1, 0],
      [1, 1]
    ].each do |row_diff, col_diff|
      next_row = row + row_diff
      next_col = col + col_diff

      while next_row.between?(0, total_rows - 1) &&
            next_col.between?(0, total_cols - 1)

        if grid[next_row][next_col] != FLOOR
          nearest_seats << grid[next_row][next_col]
          break
        end

        next_row += row_diff
        next_col += col_diff
      end
    end

    nearest_seats
  end

  def more_picky_arrange_occupants(input)
    grid = input.split("\n").map { |line| line.split('') }

    is_final_arrangement = false
    until is_final_arrangement
      is_final_arrangement = true
      new_grid = grid.map(&:dup)

      grid.each_with_index do |row_array, row|
        row_array.each_with_index do |cell, col|
          next if cell == FLOOR

          occupied_seats = nearest_seats_in_all_directions(row, col, grid).count('#')
          if cell == EMPTY && occupied_seats.zero?
            new_grid[row][col] = OCCUPIED
            is_final_arrangement = false
          end

          if cell == OCCUPIED && occupied_seats >= 5
            new_grid[row][col] = EMPTY
            is_final_arrangement = false
          end
        end
      end

      grid = new_grid
    end

    grid.flatten.count('#')
  end

  def part1
    num_occupants = nil
    File.open('./app/day11_input') do |f|
      num_occupants = arrange_occupants(f.read)
    end
    puts "Part1 Occupants #{num_occupants}"
  end

  def part2
    num_occupants = nil
    File.open('./app/day11_input') do |f|
      num_occupants = more_picky_arrange_occupants(f.read)
    end
    puts "Part2 Occupants #{num_occupants}"
  end

  def main
    part1
    part2
  end
end

Day11.main if __FILE__ == $PROGRAM_NAME
