require 'spec_helper'

describe Day18 do
  describe '#part1' do
    describe '#parse' do
      it 'splits equation into numbers, symbols, and top  level parentheses' do
        expect(Day18.parse('1 + 20 * 3 + 4023 * 5 + 6')).to eq(['1', '+', '20', '*', '3', '+', '4023', '*', '5', '+',
                                                                '6'])
        expect(Day18.parse('1 + (2 * 3) + (4 * (5 + 6))')).to eq(['1', '+', '(2 * 3)', '+', '(4 * (5 + 6))'])
      end

      it 'removes parentheses surrounding an equation if they are at the ends' do
        expect(Day18.parse('(1 + 2) * (3 + 5)')).to eq(['(1 + 2)', '*', '(3 + 5)'])
        expect(Day18.parse('(4 * (5 + 6))')).to eq(['4', '*', '(5 + 6)'])
      end
    end
    describe '#evaluate_with_new_rules' do
      it 'evaluates mathematic equations where additon and multiplication have the same precedence' do
        expect(Day18.evaluate_with_new_rules('(5 * 6)')).to eq(30)
        expect(Day18.evaluate_with_new_rules('(5 + 6)')).to eq(11)
        expect(Day18.evaluate_with_new_rules('(4 * (5 + 6))')).to eq(44)
        expect(Day18.evaluate_with_new_rules('1 + 2 * 3 + 4 * 5 + 6')).to eq(71)
        expect(Day18.evaluate_with_new_rules('1 + (2 * 3) + (4 * (5 + 6))')).to eq(51)
        expect(Day18.evaluate_with_new_rules('2 * 3 + (4 * 5)')).to eq(26)
        expect(Day18.evaluate_with_new_rules('5 + (8 * 3 + 9 + 3 * 4 * 3)')).to eq(437)
        expect(Day18.evaluate_with_new_rules('5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))')).to eq(12_240)
        expect(Day18.evaluate_with_new_rules('((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2')).to eq(13_632)
      end
    end
  end

  describe '#part2' do
    describe '#evaluate_advanced_math' do
      describe '#add_parentheses' do
        it 'adds parentheses around the two components to addition' do
          expect(Day18.add_parentheses('5 + 6')).to eq('(5 + 6)')
          expect(Day18.add_parentheses('5 + 6 * 3')).to eq('(5 + 6) * 3')
          expect(Day18.add_parentheses('5 + 6 + 7 * 3')).to eq('(5 + 6 + 7) * 3')
          expect(Day18.add_parentheses('5 + 6 * 7 + 3')).to eq('(5 + 6) * (7 + 3)')
          expect(Day18.add_parentheses('(5 + 6) + 7 * 3')).to eq('((5 + 6) + 7) * 3')
        end
      end
      it 'solves equation where addition has higher precedence than multiplication' do
        expect(Day18.evaluate_advanced_math('(5 * 6)')).to eq(30)
        expect(Day18.evaluate_advanced_math('(5 + 6)')).to eq(11)
        expect(Day18.evaluate_advanced_math('(4 * (5 + 6))')).to eq(44)
        expect(Day18.evaluate_advanced_math('1 + 2 * 3 + 4 * 5 + 6')).to eq(231)
        expect(Day18.evaluate_advanced_math('2 * 3 + (4 * 5)')).to eq(46)
        expect(Day18.evaluate_advanced_math('5 + (8 * 3 + 9 + 3 * 4 * 3)')).to eq(1445)
        expect(Day18.evaluate_advanced_math('5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))')).to eq(669_060)
        expect(Day18.evaluate_advanced_math('((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2')).to eq(23_340)
      end
    end
  end
end
