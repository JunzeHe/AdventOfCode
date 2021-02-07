require 'spec_helper'

describe Day7 do
  describe '#part1' do
    describe Day7::ColoredBag do
      let(:input) do
        <<~ABC
          light red bags contain 1 bright white bag, 2 muted yellow bags.
          dark orange bags contain 3 bright white bags, 4 muted yellow bags.
          bright white bags contain 1 shiny gold bag.
          muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
          shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
          dark olive bags contain 3 faded blue bags, 4 dotted black bags.
          vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
          faded blue bags contain no other bags.
          dotted black bags contain no other bags.
        ABC
      end

      let(:second_input) do
        <<~ABC
          shiny gold bags contain 2 dark red bags.
          dark red bags contain 2 dark orange bags.
          dark orange bags contain 2 dark yellow bags.
          dark yellow bags contain 2 dark green bags.
          dark green bags contain 2 dark blue bags.
          dark blue bags contain 2 dark violet bags.
          dark violet bags contain no other bags.
        ABC
      end

      describe '#contained_by' do
        it 'returns all bags that can eventually contain this bag' do
          rules = Day7.create_rules_tree_hash(input)
          shiny_gold = rules['shiny gold']
          expect(shiny_gold.full_contained_by.map(&:to_s)).to match_array(['bright white', 'muted yellow',
                                                                           'dark orange', 'light red'])
        end
      end

      describe '#number_of_bags_contained' do
        it 'returns the number of bags that will be contained in total' do
          rules = Day7.create_rules_tree_hash(input)
          shiny_gold = rules['shiny gold']
          expect(shiny_gold.number_of_bags_contained).to eq(32)

          rules = Day7.create_rules_tree_hash(second_input)
          shiny_gold = rules['shiny gold']
          expect(shiny_gold.number_of_bags_contained).to eq(126)
        end
      end
    end

    describe '#create_rules_tree_hash' do
      it 'creates a new key value for a new color where the key is the string '\
        'representation and the value is the node' do
        input = <<~ABC
          light red bags contain 1 bright white bag, 2 muted yellow bags.
          dark orange bags contain 3 bright white bags, 4 muted black bags.
        ABC

        rules = Day7.create_rules_tree_hash(input)
        expect(rules.keys).to match_array(['light red', 'bright white', 'muted yellow', 'dark orange', 'muted black'])
        expect(rules.values.first).to be_a(Day7::ColoredBag)

        expect(rules['light red'].can_contain).to match_array([
                                                                [rules['bright white'], 1],
                                                                [rules['muted yellow'], 2]
                                                              ])
        expect(rules['dark orange'].can_contain).to match_array([
                                                                  [rules['bright white'], 3],
                                                                  [rules['muted black'], 4]
                                                                ])
        expect(rules['bright white'].contained_by.map(&:to_s)).to match_array(['light red', 'dark orange'])
        expect(rules['muted black'].contained_by.map(&:to_s)).to match_array(['dark orange'])
        expect(rules['muted yellow'].contained_by.map(&:to_s)).to match_array(['light red'])
      end

      it 'updates a node if the string has already been seen' do
        input = <<~ABC
          light red bags contain 1 bright white bag, 2 muted yellow bags.
          dark orange bags contain 3 bright white bags, 4 muted black bags.
          pink bags contain 2 dark orange bags
        ABC

        rules = Day7.create_rules_tree_hash(input)
        expect(rules['dark orange'].contained_by.map(&:to_s)).to include('pink')
        expect(rules['pink'].can_contain.map(&:first).map(&:to_s)).to include('dark orange')
      end
    end
  end

  describe '#part2' do
  end
end
