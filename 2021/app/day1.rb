module Day1
	extend self
	def read_from_file
    data = nil
		File.open('./app/day1_input') do |file|
      data = file.readlines.map(&:chomp).map(&:to_i)
    end

    data
	end

  def find_number_pairs(input, goal_sum)
    input = input.sort
    input.reverse.each do |curr|
      input.each do |curr_pair|
        sum = curr + curr_pair
        break if sum > goal_sum
        return [curr, curr_pair] if sum == goal_sum
      end
    end
    []
  end

  def find_number_triplets(input, goal_sum)
    input = input.sort
    input.reverse.each_with_index do |curr, index|
      input.each do |curr_sec|
        input.each do |curr_third|
          sum = curr + curr_sec + curr_third
          break if sum > goal_sum
          return [curr, curr_sec, curr_third] if sum == goal_sum
        end
      end
    end

    []
  end

	def main
		input = read_from_file

    number_pairs = find_number_pairs(input, 2020)
    answer = number_pairs.reduce(:*)
    puts "Pair: #{number_pairs.join(",")} Answer: #{answer}"

    number_triplets = find_number_triplets(input, 2020)
    answer = number_triplets.reduce(:*)
    puts "Pair: #{number_triplets.join(",")} Answer: #{answer}"
	end
end

if __FILE__==$0
  Day1::main
end
