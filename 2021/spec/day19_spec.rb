require 'spec_helper'

describe Day19 do
  let(:input) do
    <<~INP
      0: 4 1 5
      1: 2 3 | 3 2
      2: 4 4 | 5 5
      3: 4 5 | 5 4
      4: "a"
      5: "b"

      ababbb
      bababa
      abbbab
      aaabbb
      aaaabbb
    INP
  end
  describe '#part1' do
    let(:rules) do
      {
        0 => '4 1 5',
        1 => '2 3 | 3 2',
        2 => '4 4 | 5 5',
        3 => '4 5 | 5 4',
        4 => 'a',
        5 => 'b'
      }
    end

    describe '#find_matches' do
      it 'returns the number of matches within the input given' do
        expect(Day19.find_matches(input)).to eq(2)
      end
    end
  end

  describe '#part2' do
  end
end
