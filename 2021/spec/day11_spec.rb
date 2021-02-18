require 'spec_helper'

describe DayX do
  let(:input) do
    <<~INP
      L.LL.LL.LL
      LLLLLLL.LL
      L.L.L..L..
      LLLL.LL.LL
      L.LL.LL.LL
      L.LLLLL.LL
      ..L.L.....
      LLLLLLLLLL
      L.LLLLLL.L
      L.LLLLL.LL
    INP
  end

  describe '#part1' do
    describe '#arrange_occupants' do
      it 'iterates on seats until there are no more seats that meet the' \
        'criteria and returns the number of occupied seats when stabilized' do
        expect(Day11.arrange_occupants(input)).to eq(37)
      end
    end
  end

  describe '#part2' do
    describe '#nearest_seats_in_all_directions' do
      let(:all_occupied) do
        <<~INP.split("\n").map { |line| line.split('') }
          .......#.
          ...#.....
          .#.......
          .........
          ..#L....#
          ....#....
          .........
          #........
          ...#.....
        INP
      end

      let(:none_occupied) do
        <<~INP.split("\n").map { |line| line.split('') }
          .##.##.
          #.#.#.#
          ##...##
          ...L...
          ##...##
          #.#.#.#
          .##.##.
        INP
      end

      let(:one_empty) do
        <<~INP.split("\n").map { |line| line.split('') }
          .............
          .L.L.#.#.#.#.
          .............
        INP
      end

      it 'returns the an array of the first seat it finds in all directions' do
        expect(Day11.nearest_seats_in_all_directions(4, 3, all_occupied)).to eq(['#'] * 8)
        expect(Day11.nearest_seats_in_all_directions(3, 3, none_occupied)).to eq([])
        expect(Day11.nearest_seats_in_all_directions(1, 1, one_empty)).to eq(['L'])
      end
    end

    describe '#more_picky_arrange_occupants' do
      it 'iterates on seats until there are no more seats that meet the' \
        'criteria and returns the number of occupied seats when stabilized' do
        expect(Day11.more_picky_arrange_occupants(input)).to eq(26)
      end
    end
  end
end
