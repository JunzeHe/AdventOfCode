require 'spec_helper'

describe Day16 do
  let(:input) do
    <<~INP
      class: 1-3 or 5-7
      row: 6-11 or 33-44
      seat: 13-40 or 45-50

      your ticket:
      7,1,14

      nearby tickets:
      7,3,47
      40,4,50
      55,2,20
      38,6,12
    INP
  end

  describe '#part1' do
    describe '#invalid_values' do
      let(:rules) do
        {
          'class' => [(1..3), (5..7)],
          'row' => [(6..11), (33..44)],
          'seat' => [(13..40), (45..50)]
        }
      end

      let(:nearby_ticket) { [55, 2, 20] }

      it 'returns the values within the ticket that are invalid for all rules' do
        expect(Day16.invalid_values(rules: rules, nearby_ticket: nearby_ticket)).to eq([55])
      end

      it 'returns an empty array if all values are valid for at least one field' do
        nearby_ticket = [7, 3, 47]
        expect(Day16.invalid_values(rules: rules, nearby_ticket: nearby_ticket)).to eq([])
      end
    end

    describe '#ticket_scanning_error_rate' do
      it 'returns the sum of all invalid values from nearby tickets' do
        expect(Day16.ticket_scanning_error_rate(input)).to eq(71)
      end
    end
  end

  describe '#part2' do
    let(:input) do
      <<~INP
        class: 0-1 or 4-19
        row: 0-5 or 8-19
        seat: 0-13 or 16-19

        your ticket:
        11,12,13

        nearby tickets:
        45,1,3
        3,9,18
        15,1,5
        5,14,9
        200,3,3
      INP
    end

    describe '#classify_your_ticket' do
      it 'returns the fields that the numbers on your ticket correspond to' do
        expect(Day16.classify_your_ticket(input)).to eq({
                                                          'class' => 12, 'row' => 11, 'seat' => 13
                                                        })
      end
    end
  end
end
