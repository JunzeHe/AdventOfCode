require 'spec_helper'

describe Day10 do
  let(:input1) do
    <<~INP
      16
      10
      15
      5
      1
      11
      7
      19
      6
      12
      4
    INP
  end

  let(:input2) do
    <<~INP
      28
      33
      18
      42
      31
      14
      46
      20
      48
      47
      24
      23
      49
      45
      19
      38
      39
      11
      1
      32
      25
      35
      8
      17
      7
      9
      4
      2
      34
      10
      3
    INP
  end

  describe '#part1' do
    describe 'adapter_differentials' do
      it 'returns a hash of differentials' do
        expect(Day10.adapter_differentials(input1)).to include({
                                                                 1 => 7,
                                                                 3 => 5
                                                               })

        expect(Day10.adapter_differentials(input2)).to eq({
                                                            1 => 22,
                                                            3 => 10
                                                          })
      end
    end
  end

  describe '#part2' do
    describe 'valid_permutations' do
      it 'returns the number of permutations possible with the given adapters' do
        expect(Day10.valid_permutations(input1)).to eq(8)
        expect(Day10.valid_permutations(input2)).to eq(19_208)
      end
    end
  end
end
