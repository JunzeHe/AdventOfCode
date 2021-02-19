module Day12
  module_function

  def parse(raw_input); end

  EAST = 'E'.freeze
  WEST = 'W'.freeze
  NORTH = 'N'.freeze
  SOUTH = 'S'.freeze
  FORWARD = 'F'.freeze
  LEFT = 'L'.freeze
  RIGHT = 'R'.freeze
  CARDINALS = [EAST, SOUTH, WEST, NORTH].freeze
  def accumulate_directions(input)
    directions = input.split("\n").map do |direction|
      p = direction.match(/(?<action>\w)(?<value>\d+)/)
      [p['action'], Integer(p['value'])]
    end

    current_direction = EAST
    tracker = {
      EAST => 0,
      NORTH => 0,
      SOUTH => 0,
      WEST => 0
    }

    directions.each do |action, value|
      int_value = Integer(value)
      case action
      when 'F'
        tracker[current_direction] += int_value
      when *CARDINALS
        tracker[action] += int_value
      when 'L'
        direction_index = CARDINALS.index(current_direction)
        new_index = (direction_index + int_value / -90) % 4
        current_direction = CARDINALS[new_index]
      when 'R'
        direction_index = CARDINALS.index(current_direction)
        new_index = (direction_index + int_value / 90) % 4
        current_direction = CARDINALS[new_index]
      end
    end

    (tracker[NORTH] - tracker[SOUTH]).abs + (tracker[EAST] - tracker[WEST]).abs
  end

  def accumulate_waypoint_directions(input)
    directions = input.split("\n").map do |direction|
      p = direction.match(/(?<action>\w)(?<value>\d+)/)
      [p['action'], Integer(p['value'])]
    end

    # [east to west, north to south]
    waypoint = [10, 1]
    location = [0, 0]

    directions.each do |action, value|
      case action
      when 'F'
        location[0] = location[0] + (waypoint[0] * value)
        location[1] = location[1] + (waypoint[1] * value)
      when EAST
        waypoint[0] += value
      when WEST
        waypoint[0] -= value
      when NORTH
        waypoint[1] += value
      when SOUTH
        waypoint[1] -= value
      when 'R'
        (value / 90).times do
          old_waypoint = waypoint.dup
          waypoint = [old_waypoint[1], -1 * old_waypoint[0]]
        end
      when 'L'
        (value / 90).times do
          old_waypoint = waypoint.dup
          waypoint = [-1 * old_waypoint[1], old_waypoint[0]]
        end
      end
    end

    location.map(&:abs).sum
  end

  def part1
    File.open('./app/day12_input') do |f|
      distance = accumulate_directions(f.read)
      puts "Part 1 Distance: #{distance}"
    end
  end

  def part2
    File.open('./app/day12_input') do |f|
      distance = accumulate_waypoint_directions(f.read)
      puts "Part 2 Distance: #{distance}"
    end
  end

  def main
    part1
    part2
  end
end

Day12.main if __FILE__ == $PROGRAM_NAME
