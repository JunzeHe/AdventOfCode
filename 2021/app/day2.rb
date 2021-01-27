module Day2
  module_function

  class Password
    attr_accessor :first_num, :second_num, :letter, :password

    def initialize(first_num:, second_num:, letter:, password:)
      @first_num = first_num
      @second_num = second_num
      @letter = letter
      @password = password
    end

    def valid?
      count = password.count(letter)
      count >= first_num && count <= second_num
    end

    def new_valid?
      at_first_position = password[first_num - 1] == letter
      at_second_position = password[second_num - 1] == letter
      at_first_position ^ at_second_position
    end
  end

  def parse(line)
    values = line.chomp.gsub('-', ' ').gsub(':', '').split(' ')
    Password.new(
      first_num: values[0].to_i,
      second_num: values[1].to_i,
      letter: values[2],
      password: values[3]
    )
  end

  def part1
    count = 0
    File.open('./app/day2_input').each_line do |line|
      password = parse(line)
      count += 1 if password.valid?
    end

    puts "Part 1 Valid Passwords: #{count}"
  end

  def part2
    count = 0
    File.open('./app/day2_input').each_line do |line|
      password = parse(line)
      count += 1 if password.new_valid?
    end

    puts "Part 2 Valid Passwords: #{count}"
  end

  def main
    part1
    part2
  end
end

Day2.main if __FILE__ == $PROGRAM_NAME
