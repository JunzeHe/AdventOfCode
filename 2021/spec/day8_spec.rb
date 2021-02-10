require 'spec_helper'

describe Day8 do
  describe '#part1' do
    describe 'parse_line' do
      it 'handles nop' do
        expect(Day8.parse_line('nop +1')).to eq(['nop', 1])
      end

      it 'hanndles acc' do
        expect(Day8.parse_line('acc +1')).to eq(['acc', 1])
      end

      it 'handles jmp' do
        expect(Day8.parse_line('jmp +1')).to eq(['jmp', 1])
      end

      it 'handles positive numbers' do
        expect(Day8.parse_line('jmp +15')).to eq(['jmp', 15])
      end

      it 'handles negative numbers' do
        expect(Day8.parse_line('jmp -20')).to eq(['jmp', -20])
      end
    end

    it 'does not detect a loop when all noop and returns 0' do
      input = <<~INP
        nop +0
        nop +5
        nop +8
        nop +17
      INP

      expect(Day8.parse_commands(input)).to eq([false, 0])
    end
    it 'does not detect a loop when all acc and returns the sum' do
      input = <<~INP
        acc +0
        acc +5
        acc +8
        acc +17
      INP

      expect(Day8.parse_commands(input)).to eq([false, 30])
    end
    it 'does return a loop and returns the sum before the loop' do
      input = <<~INP
        nop +0
        acc +1
        jmp +4
        acc +3
        jmp -3
        acc -99
        acc +1
        jmp -4
        acc +6
      INP

      expect(Day8.parse_commands(input)).to eq([true, 5])
    end
  end

  describe '#part2' do
    describe '#prevent_loop' do
      it 'determines the correct location to prevent a loop and executes again' do
        input = <<~INP
          nop +0
          acc +1
          jmp +4
          acc +3
          jmp -3
          acc -99
          acc +1
          jmp -4
          acc +6
        INP

        expect(Day8.fix_loop(input)).to eq(8)
      end
    end
  end
end
