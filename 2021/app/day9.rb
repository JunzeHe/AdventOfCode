module Day9
  module_function

  def parse(raw_input); end

  def valid_sequence(preamble:, input:)
    sequence = input.split("\n").map { |str_i| Integer(str_i) }

    sequence[preamble..].each_with_index do |num, index|
      preamble_numbers = sequence[index..(index + preamble - 1)]
      # puts "num: #{num} preamble_numbers: #{preamble_numbers}"

      valid_number = preamble_numbers.permutation(2).map(&:sum).include?(num)
      return num unless valid_number
    end

    nil
  end

  def find_continuous_components(desired_number:, input:)
    sequence = input.split("\n").map { |str_i| Integer(str_i) }

    sequence.each_with_index do |start_number, index|
      current_sum = start_number
      block = [start_number]
      search_index = index + 1
      while search_index < sequence.length && current_sum < desired_number
        current_sum += sequence[search_index]
        block << sequence[search_index]

        return block if current_sum == desired_number

        search_index += 1
      end
    end

    nil
  end

  def part1
    result = nil
    File.open('./app/day9_input') do |f|
      result = valid_sequence(preamble: 25, input: f.read)
    end
    puts "Part1 Result: #{result}"
  end

  def part2
    answer = nil
    continuous_block = nil

    File.open('./app/day9_input') do |f|
      input = f.read
      desired_number = valid_sequence(preamble: 25, input: input)
      continuous_block = find_continuous_components(desired_number: desired_number, input: input)
      sorted_block = continuous_block.sort
      answer = sorted_block.first + sorted_block.last
    end

    puts "Part2 Block: #{continuous_block}\n Answer: #{answer}"
  end

  def main
    part1
    part2
  end
end

Day9.main if __FILE__ == $PROGRAM_NAME
