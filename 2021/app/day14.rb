module Day14
  module_function

  def parse(raw_input)
    raw_input.split("\n").map do |instruction|
      mask_match = instruction.match(/\Amask = (?<mask>\w+)\z/)
      assignment_match = instruction.match(/\Amem\[(?<address>\d+)\] = (?<value>\d+)\z/)

      if mask_match
        mask_match['mask']
      elsif assignment_match
        [Integer(assignment_match['address']), Integer(assignment_match['value'])]
      end
    end
  end

  def integer_as_bits(integer)
    (0..35).to_a.reverse.map { |bit_index| integer[bit_index] }.join
  end

  def memory_values_sum(input)
    instructions = parse(input)
    memory = {}
    mask = nil

    instructions.each do |inst|
      case inst
      when String
        mask = inst
      when Array
        address, value = inst

        masked_value = integer_as_bits(value).split('').map.with_index do |bit, index|
          mask_bit = mask[index]
          next bit if mask_bit == 'X'

          mask_bit
        end.join

        memory[address] ||= 0
        memory[address] = masked_value.to_i(2)
      end
    end

    memory.values.sum
  end

  # def potential_addresses(masked_address)
  #   num_floating = masked_address.count('X')
  #
  #   floating_combinations = ([0,1] * num_floating).permutation(num_floating).to_a.uniq
  #   floating_combinations.map do |combination|
  #     address = masked_address.dup
  #     combination.map do |bit|
  #       address[address.index('X')] = bit.to_s
  #     end
  #     address.to_i(2)
  #   end
  # end
  #
  # Rewrote in recursion for speed gains of not having to generate a massive
  # set of permutations in the beginning. It was causing my machine to freeze
  # due to OOM
  def potential_addresses(masked_address)
    if masked_address.count('X').zero?
      [masked_address]
    else
      first_x = masked_address.index('X')

      use1 = masked_address.dup
      use1[first_x] = '1'

      use0 = masked_address.dup
      use0[first_x] = '0'

      [
        potential_addresses(use1),
        potential_addresses(use0)
      ].flatten
    end
  end

  def version_2_memory_values_sum(input)
    instructions = parse(input)
    memory = {}
    mask = nil

    instructions.each.with_index do |inst, index|
      case inst
      when String
        mask = inst
      when Array
        input_address, value = inst

        masked_address = integer_as_bits(input_address).split('').map.with_index do |bit, bits_index|
          mask_bit = mask[bits_index]
          case mask_bit
          when 'X'
            'X'
          when '1'
            1
          when '0'
            bit
          end
        end.join

        addresses = potential_addresses(masked_address)
        puts "Instruction #{index} #{addresses.length} Addresses to update"
        addresses.each do |address|
          memory[address] = value
        end
      end
    end

    memory.values.sum
  end

  def part1
    File.open('./app/day14_input') do |f|
      puts "Part 1 #{memory_values_sum(f.read)}"
    end
  end

  def part2
    File.open('./app/day14_input') do |f|
      puts "Part 2 #{version_2_memory_values_sum(f.read)}"
    end
  end

  def main
    part1
    part2
  end
end

Day14.main if __FILE__ == $PROGRAM_NAME
