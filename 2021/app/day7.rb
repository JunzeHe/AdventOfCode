module Day7
  module_function

  class ColoredBag
    attr_reader :color_string, :can_contain, :contained_by

    def initialize(color_string)
      @color_string = color_string
      # a nested array where each element is of the format [colored_bag, amount of bags allowed]
      @can_contain = []
      @contained_by = []
    end

    def full_contained_by
      get_parents(self)
    end

    def get_parents(current)
      if current.contained_by.empty?
        []
      else
        current.contained_by.map do |colored_bag|
          get_parents(colored_bag) + [colored_bag]
        end.flatten.uniq
      end
    end

    def number_of_bags_contained
      if can_contain.empty?
        0
      else
        can_contain.map do |colored_bag, count|
          count + (count * colored_bag.number_of_bags_contained)
        end.sum
      end
    end

    def add_can_contain(colored_bag, count)
      raise 'Invalid type' unless colored_bag.is_a?(Day7::ColoredBag)
      return if @can_contain.map(&:first).map(&:to_s).include?(colored_bag.to_s)

      @can_contain << [colored_bag, Integer(count)]
    end

    def add_contained_by(colored_bag)
      raise 'Invalid type' unless colored_bag.is_a?(Day7::ColoredBag)

      @contained_by << colored_bag unless @contained_by.map(&:to_s).include?(colored_bag.to_s)
    end

    def to_s
      @color_string
    end

    def ==(other)
      color_string == other.color_string
    end
  end

  def parse(raw_input); end

  def create_rules_tree_hash(input)
    rules = {}
    input.split("\n").each do |rule|
      containing_color = rule.match(/\A(?<containing_color>[\w\s]+) bags contain.*\z/)[:containing_color]
      colors_contained = rule.scan(/(\d) ([\s\w]+) bag/)

      rules[containing_color] ||= ColoredBag.new(containing_color)

      colors_contained.map do |count, color|
        rules[color] ||= ColoredBag.new(color)
        rules[containing_color].add_can_contain(rules[color], count)
        rules[color].add_contained_by(rules[containing_color])
      end
    end
    rules
  end

  def part1
    rules = {}
    File.open('./app/day7_input') do |f|
      input = f.read.chomp
      rules = create_rules_tree_hash(input)
    end
    puts "Part1 #{rules['shiny gold'].full_contained_by.count} bags can eventually hold a shiny gold bag"
  end

  def part2
    rules = {}
    File.open('./app/day7_input') do |f|
      input = f.read.chomp
      rules = create_rules_tree_hash(input)
    end
    puts "Part2 There are #{rules['shiny gold'].number_of_bags_contained} bags inside the shiny gold bag"
  end

  def main
    part1
    part2
  end
end

Day7.main if __FILE__ == $PROGRAM_NAME
