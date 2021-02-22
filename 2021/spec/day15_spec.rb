require 'spec_helper'

describe Day15 do
  describe '#part1' do
    describe '#memory_game' do
      it 'accepts starting input, and the number of turns to return the number spoken on that last turn' do
        turns = 2020
        expect(Day15.memory_game(input: '0,3,6', turns: turns)).to eq(436)
        expect(Day15.memory_game(input: '1,3,2', turns: turns)).to eq(1)
        expect(Day15.memory_game(input: '2,1,3', turns: turns)).to eq(10)
        expect(Day15.memory_game(input: '1,2,3', turns: turns)).to eq(27)
        expect(Day15.memory_game(input: '2,3,1', turns: turns)).to eq(78)
        expect(Day15.memory_game(input: '3,2,1', turns: turns)).to eq(438)
        expect(Day15.memory_game(input: '3,1,2', turns: turns)).to eq(1836)
      end

      it 'works even with larger turn counts' do
        turns = 30_000_000

        expect(Day15.memory_game(input: '0,3,6', turns: turns)).to eq(175_594)
        # expect(Day15.memory_game(input: "1,3,2", turns: turns)).to eq(2578)
        # expect(Day15.memory_game(input: "2,1,3", turns: turns)).to eq(3544142)
        # expect(Day15.memory_game(input: "1,2,3", turns: turns)).to eq(261214)
        # expect(Day15.memory_game(input: "2,3,1", turns: turns)).to eq(6895259)
        # expect(Day15.memory_game(input: "3,2,1", turns: turns)).to eq(18)
        # expect(Day15.memory_game(input: "3,1,2", turns: turns)).to eq(362)
      end
    end
  end

  describe '#part2' do
  end
end
