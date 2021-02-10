module Day8
  module_function

  def parse_line(line)
    command, string_amount = line.split(' ')

    integer_amount = Integer(string_amount[1..])
    integer_amount *= -1 if string_amount[0] == '-'

    [command, integer_amount]
  end

  def parse_commands(string_commands)
    commands = string_commands.split("\n").map { |line| parse_line(line) }

    execute(commands)
  end

  def execute(commands)
    agg = 0
    command_index = 0
    unvisited_lines = [true] * commands.length
    looped = false
    while command_index != commands.length
      unless unvisited_lines[command_index]
        looped = true
        break
      end

      command, amount = commands[command_index]
      unvisited_lines[command_index] = false
      # puts "Command #{command} Amount #{amount} Index #{command_index} Visited? #{unvisited_lines[command_index]}"
      case command
      when 'nop'
        command_index += 1
      when 'acc'
        agg += amount
        command_index += 1
      when 'jmp'
        command_index += amount
      end
    end

    [looped, agg]
  end

  def flip_command(cmd)
    {
      'nop' => 'jmp',
      'jmp' => 'nop'
    }[cmd]
  end

  def fix_loop(string_commands)
    commands = string_commands.split("\n").map { |line| parse_line(line) }

    command_index = 0
    looped, agg = execute(commands)
    while looped && command_index < commands.length
      unless commands[command_index][0] == 'acc'
        original_command = commands[command_index][0]
        commands[command_index][0] = flip_command(original_command)

        looped, agg = execute(commands)

        commands[command_index][0] = original_command if looped
      end
      command_index += 1
    end

    agg
  end

  def part1
    agg = nil
    File.open('./app/day8_input') do |f|
      input = f.read
      agg = parse_commands(input)
    end
    puts "Part1 agg: #{agg}"
  end

  def part2
    agg = nil
    File.open('./app/day8_input') do |f|
      input = f.read
      agg = fix_loop(input)
    end
    puts "Part2 agg: #{agg}"
  end

  def main
    part1
    part2
  end
end

Day8.main if __FILE__ == $PROGRAM_NAME
