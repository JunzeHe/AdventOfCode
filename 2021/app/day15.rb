module Day15
  module_function

  def parse(raw_input); end

  def memory_game(input:, turns:)
    starting_numbers = input.split(',').map(&:to_i)

    # format: <number> => [ turns previously used ]
    # [ turns previously used ] should be truncated to only be the last two times
    # Always append to the end and pop from the front
    history = {}
    turn = 1
    last_number = nil
    number = nil

    while turn <= turns
      number = if starting_numbers.any?
                 starting_numbers.shift
               elsif !history.key?(last_number) || (history[last_number].length == 1)
                 0
               else
                 history[last_number].last - history[last_number].first
               end

      history[number] ||= []
      history[number] << turn
      if history[number].length > 2
        history[number] = history[number][-2..] # truncate to be last two
      end

      # puts "Turn: #{turn} Last Number: #{last_number}" \
      #   " Current Number: #{number} History[last_number]: #{history[last_number]}"
      #
      puts "Turns remaining: #{turns - turn}"

      last_number = number

      turn += 1
    end

    number
  end

  INPUT = '0,1,4,13,15,12,16'.freeze
  def part1
    puts "Part 1: #{memory_game(input: INPUT, turns: 2020)}"
  end

  def part2
    puts "Part 2: #{memory_game(input: INPUT, turns: 30_000_000)}"
  end

  def main
    part1
    part2
  end
end

Day15.main if __FILE__ == $PROGRAM_NAME
