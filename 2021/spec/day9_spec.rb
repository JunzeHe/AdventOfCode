require 'spec_helper'

describe Day9 do
  let(:input) do
    <<~INP
      35
      20
      15
      25
      47
      40
      62
      55
      65
      95
      102
      117
      150
      182
      127
      219
      299
      277
      309
      576
    INP
  end

  describe '#part1' do
    describe 'valid_number' do
      it 'returns the number that causes the sequence to be invalid' do
        expect(Day9.valid_sequence(preamble: 5, input: input)).to eq(127)
      end

      it 'returns nil if all numbers are valid' do
        expect(Day9.valid_sequence(preamble: 15, input: input)).to eq(nil)
      end
    end
  end

  describe '#part2' do
    describe 'find_continuous_components' do
      it 'returns the a a continous string of numbers that add up to the provided number' do
        expect(Day9.find_continuous_components(input: input, desired_number: 127)).to eq([15, 25, 47, 40])
      end
    end
  end
end
