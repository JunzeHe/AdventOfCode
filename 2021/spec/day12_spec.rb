require 'spec_helper'

describe Day12 do
  let(:input) do
    <<~INP
      F10
      N3
      F7
      R90
      F11
    INP
  end
  describe '#part1' do
    describe '#accumulate_directions' do
      it 'accumulates directions and returns the manhattan distance upon completion' do
        expect(Day12.accumulate_directions(input)).to eq(25)
      end
    end
  end

  describe '#part2' do
    describe '#accumulate_waypoint_directions' do
      it 'adjusts the waypoint and the ship relative to the waypoint' do
        expect(Day12.accumulate_waypoint_directions(input)).to eq(286)
      end
    end
  end
end
