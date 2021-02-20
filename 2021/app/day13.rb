module Day13
  module_function

  def parse(raw_input)
    departure_time_str, buses_str = raw_input.split("\n")
    departure_time = Integer(departure_time_str)
    buses = buses_str
            .split(',')
            .filter { |bus| bus != 'x' }
            .map { |bus| Integer(bus) }

    [departure_time, buses]
  end

  def find_best_bus(input)
    departure_time, buses = parse(input)

    nearest_bus = nil
    nearest_bus_arrival = departure_time * 10
    buses.each do |bus|
      bus_arrival = bus * (departure_time / bus + 1)
      if bus_arrival < nearest_bus_arrival
        nearest_bus = bus
        nearest_bus_arrival = bus_arrival
      end
    end

    [nearest_bus, nearest_bus_arrival]
  end

  def calculate(input)
    nearest_bus, nearest_bus_arrival = find_best_bus(input)
    departure_time, = parse(input)

    (nearest_bus_arrival - departure_time) * nearest_bus
  end

  def find_bus_sync(input)
    buses = input.split(',').map do |bus_str|
      next if bus_str == 'x'

      Integer(bus_str)
    end

    # Brute forcing solving this instead of using Chinese Reminder Theorem
    # which is too much math for me. Here, we use a step of the largest bus id
    # since the eventual timestamp will be close to the max offset by the max's
    # location in the order. Should be slightly faster than iterating 1 by 1

    cycle = 1
    step_count = buses.compact.max
    index_of_max = buses.index(step_count)
    earliest_timestamp_of_max = cycle
    loop do
      is_match = buses.map.with_index do |bus, index|
        next if bus.nil?

        ((earliest_timestamp_of_max + index - index_of_max) % bus).zero?
      end.compact.reduce(:&)

      break if is_match

      puts "Cycle: #{cycle} Timestamp: #{earliest_timestamp_of_max} is_match: #{is_match}"
      cycle += 1
      earliest_timestamp_of_max = step_count * cycle
    end

    earliest_timestamp_of_max - index_of_max
  end

  def part1
    File.open('./app/day13_input') do |f|
      puts "Part1 #{calculate(f.read)}"
    end
  end

  def part2
    File.open('./app/day13_input') do |f|
      buses_str = f.read.split("\n")[-1]
      puts "Part2 #{find_bus_sync(buses_str)}"
    end
  end

  def main
    part1
    puts 'Part2 technically will work, but you better have a loooooot of patience if you want to brute force it'
    # part2
  end
end

Day13.main if __FILE__ == $PROGRAM_NAME
