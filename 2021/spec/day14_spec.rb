require 'spec_helper'

describe Day14 do
  let(:input) do
    <<~INP
      mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X
      mem[8] = 11
      mem[7] = 101
      mem[8] = 0
    INP
  end

  describe '#part1' do
    describe 'memory_values_sum' do
      it 'parses the instructions for modifying a memory register' do
        expect(Day14.memory_values_sum(input)).to eq(165)
      end
    end
  end

  describe '#part2' do
    describe 'version_2_memory_values_sum' do
      let(:input) do
        <<~INP
          mask = 000000000000000000000000000000X1001X
          mem[42] = 100
          mask = 00000000000000000000000000000000X0XX
          mem[26] = 1
        INP
      end
      it 'applies the mask on the memory address before setting value' do
        expect(Day14.version_2_memory_values_sum(input)).to eq(208)
      end
    end
  end
end
