module Day17
  module_function

  def parse(raw_input); end

  def neighboring_cube_coordinates(initial:)
    neighbors = get_neighbors(initial: initial, current: [])
    neighbors.delete(initial)
    neighbors
  end

  def get_neighbors(initial:, current:)
    if initial.length == current.length
      return current
    end

    next_coordinate = initial[current.length]

    neighbors = [
      get_neighbors(initial: initial, current: current + [next_coordinate]),
      get_neighbors(initial: initial, current: current + [next_coordinate + 1]),
      get_neighbors(initial: initial, current: current + [next_coordinate - 1]),
    ]
    neighbors = neighbors.flatten(1) if neighbors.dig(0,0).is_a?(Array)
    neighbors
  end

  ACTIVE = '#'.freeze
  INACTIVE = '.'.freeze
  def find_active_cubes(input:, cycles:, dimensions:)
    # Each cycle:
    #   Start from a central point within current grid (any point)
    #   Recursively visit its neighbors and their neighbors, until no longer a
    #   neighbor of any cube within the grid's edge ( e.g difference between
    #   one of its coordinates is 2 away from the min maxes of coordinates )
    #   Update the boundaries

    grid = init_grid(input)

    cycle = 0
    while cycle != cycles
      new_grid = {}
      boundaries = establish_boundaries(grid)
      check_neighbors(grid, new_grid, boundaries, [0, 0, 0])
      grid = new_grid

      cycle += 1
    end

    # Count total active cubes in the final cycle
    grid.sort_by { |z, _| z }.flat_map do |_z_level, plane|
      plane.sort_by { |y, _| y }.flat_map do |_y_level, x_row|
        x_row.sort_by { |x, _status| x }.map(&:last).select { |status| status == ACTIVE }
      end
    end.count
  end

  # Ruby is pass by reference if modifying the passed in object (adding new
  # keys), but pass by value if reassigning first (updating variable)
  def check_neighbors(grid, new_grid, boundaries, current)
    if !current[0].between?(*boundaries[0]) ||
       !current[1].between?(*boundaries[1]) ||
       !current[2].between?(*boundaries[2])
      return nil
    end

    # Find neighbors
    neighbors = neighboring_cube_coordinates(initial: current)
    status = grid.dig(*current) || INACTIVE

    # Count Active Neighbors
    active_neighbors = 0
    neighbors.each do |neighbor|
      neighbor_status = grid.dig(*neighbor) || INACTIVE
      active_neighbors += 1 if neighbor_status == ACTIVE

      # 4 or more active neighbors do not trigger any conditions, so avoid extra lookups
      break if active_neighbors == 4
    end

    # Determine New Status
    new_status = grid.dig(*current) || INACTIVE
    case status
    when ACTIVE
      new_status = if active_neighbors.between?(2, 3)
                     ACTIVE
                   else
                     INACTIVE
                   end
    when INACTIVE
      new_status = ACTIVE if active_neighbors == 3
    end

    new_grid[current[0]] ||= {}
    new_grid[current[0]][current[1]] ||= {}
    new_grid[current[0]][current[1]][current[2]] = new_status

    # Check on unchecked neighbors
    neighbors.each do |neighbor|
      check_neighbors(grid, new_grid, boundaries, neighbor) if new_grid.dig(*neighbor).nil?
    end
  end

  def establish_boundaries(grid)
    all_ys = grid.map do |_z, columns|
      columns.keys
    end.flatten.uniq

    all_xs = []
    grid.each do |_z, columns|
      columns.each do |_y, points|
        all_xs += points.keys
      end
    end
    all_xs = all_xs.uniq

    z_range = [grid.keys.min - 1, grid.keys.max + 1]
    y_range = [all_ys.min - 1, all_ys.max + 1]
    x_range = [all_xs.min - 1, all_xs.max + 1]

    [z_range, y_range, x_range]
  end

  def init_grid(input)
    # [z, y, x] for easier outputting for troubleshooting
    grid = {}

    initial_z = 0
    input.split("\n").each.with_index do |row, y|
      row.split('').each.with_index do |status, x|
        grid[initial_z] ||= {}
        grid[initial_z][y] ||= {}
        grid[initial_z][y][x] = status
      end
    end

    grid
  end

  def output_grid(grid)
    # Make sure to sort the keys/coordinate for correct output
    grid.sort_by { |z, _| z }.each do |z_level, plane|
      puts "z=#{z_level}"
      plane.sort_by { |y, _| y }.each do |_y_level, x_row|
        puts x_row.sort_by { |x, _status| x }.map(&:last).join
      end
    end

    nil
  end

  def part1
    # Regardless of depth first or breadth first search, it will still need to
    # enqueue a check for each new neighbor. Up to a certain point, you will
    # need to increase the stack size.
    # execute `export RUBY_THREAD_VM_STACK_SIZE=150000000` first to increase stack size

    File.open('./app/day17_input') do |f|
      puts find_active_cubes(input: f.read, cycles: 6)
    end
  end

  def part2
    File.open('./app/day17_input') do |f|
      # puts f.read
    end
  end

  def main
    part1
    part2
  end
end

Day17.main if __FILE__ == $PROGRAM_NAME
