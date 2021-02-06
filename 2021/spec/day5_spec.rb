require 'spec_helper'

describe Day5 do
  describe '#part1' do
    describe 'seat_row' do
      it 'returns the seat row given the first seven characters of a seat location' do
        expect(Day5.seat_row('FBFBBFF')).to eq(44)
        expect(Day5.seat_row('BFFFBBF')).to eq(70)
        expect(Day5.seat_row('FFFBBBF')).to eq(14)
        expect(Day5.seat_row('BBFFBBF')).to eq(102)
      end
    end

    describe 'seat_column' do
      it 'returns the seat column given the last 3 characters of a seat location' do
        expect(Day5.seat_column('RLR')).to eq(5)
        expect(Day5.seat_column('RRR')).to eq(7)
        expect(Day5.seat_column('RRR')).to eq(7)
        expect(Day5.seat_column('RLL')).to eq(4)
      end
    end

    describe 'seat_id' do
      it 'calculates the seat_id given a seat_location' do
        expect(Day5.seat_id('FBFBBFFRLR')).to eq(357)
        expect(Day5.seat_id('BFFFBBFRRR')).to eq(567)
        expect(Day5.seat_id('FFFBBBFRRR')).to eq(119)
        expect(Day5.seat_id('BBFFBBFRLL')).to eq(820)
      end
    end
  end

  describe '#part2' do
  end
end
