require 'spec_helper'

describe Day6 do
  describe '#part1' do
    describe '#yeses_per_group' do
      it 'counts the number of unique questions answered yes to per group' do
        group_answers = <<~ABC.chomp.split("\n")
          abcx
          abcy
          abcz
        ABC

        expect(Day6.yeses_per_group(group_answers)).to eq(6)
      end
    end

    describe '#total_yeses' do
      it 'counts the total number of unique yeses per group' do
        all_answers = <<~ABC.chomp.split("\n\n").map { |a| a.split("\n") }
          abc

          a
          b
          c

          ab
          ac

          a
          a
          a
          a

          b
        ABC

        expect(Day6.total_yeses(all_answers)).to eq(11)
      end
    end
  end

  describe '#part2' do
    describe '#questions_with_all_yeses' do
      it 'calculates the number of questions that everyone answered yes to' do
        group_answers = <<~ABC.chomp.split("\n")
          abcx
          abcy
          abcz
        ABC

        expect(Day6.questions_with_all_yeses(group_answers)).to eq(3)
      end
    end

    describe '#total_yeses_with_all_yeses' do
      it 'calculates the sum per group of questions that everyone answered yes to' do
        all_answers = <<~ABC.chomp.split("\n\n").map { |a| a.split("\n") }
          abc

          a
          b
          c

          ab
          ac

          a
          a
          a
          a

          b
        ABC

        expect(Day6.total_yeses_with_all_yeses(all_answers)).to eq(6)
      end
    end
  end
end
