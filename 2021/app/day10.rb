module Day10
  module_function

  def adapter_differentials(input)
    adapters = input.split("\n").map(&:to_i).sort
    adapters = adapters.prepend(0).push(adapters.last + 3)

    differentials = {}

    adapters[..-2].each_with_index do |joltage, index|
      next_joltage = adapters[index + 1]

      difference = next_joltage - joltage

      differentials[difference] ||= 0
      differentials[difference] += 1
    end

    differentials
  end

  # Solution to part 2 is from a Reddit answer, I couldn't find the pattern :(
  def get_chunks(array)
    tolerance = 3
    array.unshift(0)
    array << array.last + 3
    chunks = [[]]
    current_chunk = 0
    array.each_index do |i|
      next if i < 1
      break if i >= array.length - 1

      if array[i + 1] - array[i - 1] < tolerance
        chunks[current_chunk] << array[i]
      elsif !chunks[current_chunk].empty?
        chunks << []
        current_chunk += 1
      end
    end
    chunks.delete_at(chunks.length - 1) if chunks.empty?
    chunks
  end

  def count_sequences(array)
    chunks = get_chunks(array)
    count = 1

    chunks.each do |chunk|
      count *= if chunk.length == 3
                 (2**chunk.length) - 1
               else
                 2**chunk.length
               end
    end
    count
  end

  def valid_permutations(input)
    adapters = input.split("\n").map(&:to_i).sort
    count_sequences(adapters)
  end

  def part1
    result = nil
    File.open('./app/day10_input') do |f|
      differentials = adapter_differentials(f.read)
      result = differentials[1] * differentials[3]
    end
    puts "Part1 Result: #{result}"
  end

  def part2
    result = nil
    File.open('./app/day10_input') do |f|
      file = f.read
      result = valid_permutations(file)
    end
    puts "Part2 Result: #{result}"
  end

  def main
    part1
    part2
  end
end

Day10.main if __FILE__ == $PROGRAM_NAME
