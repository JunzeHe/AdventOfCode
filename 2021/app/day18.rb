module Day18
  module_function

  def is_symbol?(char)
    ['*', '+'].include?(char)
  end

  def parse(raw_input)
    split_up = []

    if raw_input[0] == '(' && raw_input[-1] == ')'
      parens = raw_input.each_char.select do |char|
        ['(', ')'].include?(char)
      end

      open_parens = 0
      always_within_parens = true # Detect for parens wrapping around entire equation
      parens.each.with_index do |char, index|
        if char == '('
          open_parens += 1
        else
          open_parens -= 1
          always_within_parens = false if index != parens.length - 1 && open_parens == 0
        end
      end

      raw_input = raw_input[1..-2] if always_within_parens
    end

    open_parens = 0
    raw_input.each_char.with_index do |char, _index|
      if char == '('
        open_parens += 1

        if open_parens == 1
          # Start a new chunk
          split_up << char
          next
        end
      end

      if char == ')'
        # Stop current chunk
        open_parens -= 1
        # Close current chunk
        split_up[-1] += char
        next
      end

      if open_parens > 0
        # Group everything within a parenthesese
        split_up[-1] += char
      elsif is_symbol?(char)
        split_up << char
      elsif char != ' '
        if is_symbol?(split_up.last) || split_up.empty?
          split_up << char
        else
          # Combine numbers together
          split_up[-1] += char
        end
      end
    end

    split_up
  end

  def solve_with_basic_math(parsed_equation)
    # evaluate simple equations left to right

    total = nil
    operator = nil
    parsed_equation.each do |char|
      integer_char = begin
        Integer(char)
      rescue StandardError
        nil
      end
      if integer_char.nil?
        operator = char
      else
        if total.nil?
          total = integer_char
          next
        end

        if operator == '+'
          total += integer_char
        elsif operator == '*'
          total *= integer_char
        end

        operator = nil
      end
    end

    total
  end

  def evaluate_with_new_rules(equation)
    # Evaluate everything inside of a parentheses first, until it becomes only one number, recurse as needed
    parsed_equation = parse(equation)

    if parsed_equation.join('').include?('(')
      # evaluate things in parentheses first
      evaluated_equation = parsed_equation.map do |component|
        if component.include?('(')
          evaluate_with_new_rules(component)
        else
          component
        end
      end

      solve_with_basic_math(evaluated_equation)
    else
      solve_with_basic_math(parsed_equation)
    end
  end

  def add_parentheses(equation)
    unless equation.include?('*')
      if equation.include?('+')
        return "(#{equation})"
      else
        return equation
      end
    end

    split_up = equation.split('*').map(&:strip)
    split_up.map { |component| add_parentheses(component) }.join(' * ')
  end

  def evaluate_advanced_math(equation)
    # Evaluate things in parens first to remove those parens
    # Then add Add parentheses around additions to set precedence
    # Evaluate as before

    parsed_equation = parse(equation)
    parsed_equation_sr = parsed_equation.join('')

    if !parsed_equation_sr.include?('(') &&
       (parsed_equation_sr.include?('*') && !parsed_equation_sr.include?('+')) ||
       (parsed_equation_sr.include?('+') && !parsed_equation_sr.include?('*'))
      solve_with_basic_math(parsed_equation)
    else
      evaluated_equation = parsed_equation.map do |component|
        if component.include?('(')
          evaluate_advanced_math(component)
        else
          component
        end
      end

      updated_equation = add_parentheses(evaluated_equation.join(' '))
      evaluate_advanced_math(updated_equation)
    end
  end

  def part1
    sum = 0

    File.open('./app/day18_input') do |f|
      lines = f.read.split("\n")
      total = 0
      lines.each do |line|
        total += evaluate_with_new_rules(line)
      end

      puts "Part1 Total: #{total}"
    end
  end

  # Doesn't fully work
  def part2
    sum = 0

    File.open('./app/day18_input') do |f|
      lines = f.read.split("\n")
      total = 0
      lines.each do |line|
        total += evaluate_advanced_math(line)
      end

      puts "Part2 Total: #{total}"
    end
  end

  def main
    part1
    part2
  end
end

Day18.main if __FILE__ == $PROGRAM_NAME
