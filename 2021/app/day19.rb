module Day19
  module_function

  def parse(raw_input)
    raw_rules, raw_strings = raw_input.split("\n\n")
    rules = raw_rules.split("\n").each_with_object({}) do |str_rule, agg|
      rule_number, values = str_rule.split(': ')
      # extra space is a delimiter between rule references
      agg[Integer(rule_number)] = " #{values.gsub('"', '')} "
    end

    strings = raw_strings.split("\n")

    [rules, strings]
  end

  def root_rules(rules)
    rules.select do |_rule_number, rule|
      rule.match?(/\A([^\d]+\s*)\z/)
    end
  end

  def find_matches(input)
    # Parse the rules
    original_rules, strings = parse(input)

    # Iterate until none of the rules/values point to another rule
    # For each cycle, find all of the rules that do not point to another rule.
    # Then find all of the rules that reference those "root rules" and replace references with real values
    # By the end rule 0 will have been evaluated and can be transformed into a regex
    rules = original_rules.dup
    roots = root_rules(rules)
    while roots.keys.length != rules.keys.length
      # puts "Roots: #{roots.keys.length} Total Rules: #{rules.keys.length}"

      rules.each do |rule_number, rule|
        new_rule = rule.dup
        roots.each do |root_rule_number, root_rule|
          new_rule = new_rule.gsub(" #{root_rule_number} ", " (#{root_rule}) ")
        end

        rules[rule_number] = new_rule
      end

      roots = root_rules(rules)
    end

    # Conver to regex
    rules.each do |rule_number, rule|
      rules[rule_number] = /\A(#{rule.gsub(" ", "")})\z/
    end

    # Find matches
    matched_strings = strings.select do |str|
      str.match?(rules[0])
    end

    matched_strings.count
  end

  def part1
    File.open('./app/day19_input') do |f|
      puts "Part 1: #{find_matches(f.read)}"
    end
  end

  def part2
    File.open('./app/day19_input') do |f|
      # puts f.read
    end
  end

  def main
    part1
    part2
  end
end

Day19.main if __FILE__ == $PROGRAM_NAME
