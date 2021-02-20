require 'spec_helper'

describe Day13 do
  let(:input) do
    <<~INP
      939
      7,13,x,x,59,x,31,19
    INP
  end

  describe '#part1' do
    describe '#find_best_bus' do
      it 'finds the bus that will arrive the soonest after earliest departure' do
        expect(Day13.find_best_bus(input)).to eq([59, 944])
      end
    end

    describe '#calculate' do
      it 'calculates the correct answer using the nearest_bus_arrival_time' do
        expect(Day13.calculate(input)).to eq(295)
      end
    end
  end

  describe '#part2' do
    describe '#find_bus_sync' do
      it 'finds the first timestamp at which the buses depart one after another' do
        expect(Day13.find_bus_sync('7,13,x,x,59,x,31,19')).to eq(1_068_781)
        expect(Day13.find_bus_sync('17,x,13,19')).to eq(3417)
        expect(Day13.find_bus_sync('67,7,59,61')).to eq(754_018)
        expect(Day13.find_bus_sync('67,x,7,59,61')).to eq(779_210)
        expect(Day13.find_bus_sync('67,7,x,59,61')).to eq(1_261_476)
        expect(Day13.find_bus_sync('1789,37,47,1889')).to eq(1_202_161_486)
      end
    end
  end
end
