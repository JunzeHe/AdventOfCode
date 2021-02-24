require 'spec_helper'

describe Day17 do
  let(:input) do
    <<~INP
          .#.
          ..#
          ###
    INP
  end

  describe '#part1' do
    describe '#neighboring_cube_coordinates' do
      it 'returns a list of coordinates that correspond to the neighbors of the given cube' do
        initial = [1, 2, 3]
        result = Day17.neighboring_cube_coordinates(initial: initial)
        expect(result.length).to eq(26)
        result.each do |neighbor|
          neighbor.zip(initial).each do |neighbor_coordinate, initial_coordinate|
            expect((neighbor_coordinate - initial_coordinate).abs).to be <= 1
          end
        end
      end
    end
    describe '#find_active_cubes' do
      it 'returns the number of active cubes after n cycles starting with the initial configuration ' do
        expect(Day17.find_active_cubes(input: input, cycles: 6, dimensions: 3)).to eq(112)
      end
    end
  end

  describe '#part2' do
    describe '#neighboring_cube_coordinates' do
      it 'returns a list of coordinates that correspond to the neighbors of the' \
       'given cube in every direction' do
        initial = [1, 2, 3, 4]
        result = Day17.neighboring_cube_coordinates(initial: initial)
        expect(result.length).to eq(80)
        result.each do |neighbor|
          neighbor.zip(initial).each do |neighbor_coordinate, initial_coordinate|
            expect((neighbor_coordinate - initial_coordinate).abs).to be <= 1
          end
        end
      end
    end

    describe '#find_active_cubes' do
      it 'returns the number of active cubes after n cycles starting with the initial configuration ' do
        expect(Day17.find_active_cubes(input: input, cycles: 6, dimensions: 4)).to eq(848)
      end
    end
  end
end
