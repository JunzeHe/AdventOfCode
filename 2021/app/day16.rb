module Day16
  module_function

  def parse(raw_input)
    rules_str, your_ticket_str, nearby_tickets_str = raw_input.split("\n\n")

    rules = rules_str.split("\n").each_with_object({}) do |rule, agg|
      match = rule.match(/
                         \A
                         (?<rule_name>.+):\s
                         (?<first_min>\d+)-(?<first_max>\d+)\s
                         or\s(?<second_min>\d+)-(?<second_max>\d+)
                         \z
                         /x)
      agg[match['rule_name']] = [
        (match['first_min'].to_i..match['first_max'].to_i),
        (match['second_min'].to_i..match['second_max'].to_i)
      ]
    end

    your_ticket = your_ticket_str.split("\n").last.split(',').map(&:to_i)

    nearby_tickets = nearby_tickets_str.split("\n")[1..].map do |nearby_ticket|
      nearby_ticket.split(',').map(&:to_i)
    end

    [rules, your_ticket, nearby_tickets]
  end

  def invalid_values(rules:, nearby_ticket:)
    all_rules = rules.values.flatten
    nearby_ticket.filter do |ticket_val|
      valid = all_rules.map do |rule|
        rule.include?(ticket_val)
      end.reduce(:|)
      !valid
    end
  end

  def ticket_scanning_error_rate(input)
    rules, _your_ticket, nearby_tickets = parse(input)

    nearby_tickets.map do |nearby_ticket|
      invalid_values(rules: rules, nearby_ticket: nearby_ticket)
    end.flatten.sum
  end

  def classify_your_ticket(input)
    rules, your_ticket, nearby_tickets = parse(input)

    valid_nearby_tickets = nearby_tickets.select do |nearby_ticket|
      invalid_values(rules: rules, nearby_ticket: nearby_ticket).empty?
    end

    columns_and_values = valid_nearby_tickets.each_with_object({}) do |ticket, agg|
      ticket.each_with_index do |val, i|
        agg[i] ||= []
        agg[i] << val
      end
    end

    potential_matches = {}
    rules.each do |rule_name, rule_range|
      columns_and_values.each do |column, values|
        is_potential_match = values.map do |value|
          rule_range.first.include?(value) || rule_range.last.include?(value)
        end.reduce(:&)

        if is_potential_match
          potential_matches[rule_name] ||= []
          potential_matches[rule_name] << column
        end
      end
    end

    matches_found = {}
    # Find guaranteed matches, rule names where there can only be only possible column
    # Then loop over all potential matches removing those guaranteed matches as potential matches from all rule_names
    # Keep looping until there are no  more potential matches
    until potential_matches.empty?
      # Filter out for unique matches such that each column can only correspond to one rule_name
      rules_found = potential_matches.map do |rule_name, matches|
        if matches.length == 1
          matches_found[rule_name] = matches.first
          rule_name
        end
      end

      rules_found.each do |rule_name|
        potential_matches.delete(rule_name)
      end

      potential_matches.each do |_rule_name, matches|
        matches_found.values.flatten.each do |matched_column|
          matches.delete(matched_column)
        end
      end
    end

    classified_ticket = {}
    matches_found.each do |rule_name, column|
      classified_ticket[rule_name] = your_ticket[column.to_i]
    end

    classified_ticket
  end

  def part1
    File.open('./app/day16_input') do |f|
      puts "Part 1: #{ticket_scanning_error_rate(f.read)}"
    end
  end

  def part2
    File.open('./app/day16_input') do |f|
      classified_ticket = classify_your_ticket(f.read)
      answer = classified_ticket.filter do |rule_name, _value|
        rule_name.start_with?('departure')
      end.values.reduce(:*)
      puts "Part 2: #{answer}"
    end
  end

  def main
    part1
    part2
  end
end

Day16.main if __FILE__ == $PROGRAM_NAME
