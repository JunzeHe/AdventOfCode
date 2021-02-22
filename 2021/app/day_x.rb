module DayX
  module_function

  def parse(raw_input); end

  def part1
    File.open('./app/dayX_input') do |f|
      puts f.read
    end
  end

  def part2
    File.open('./app/dayX_input') do |f|
      puts f.read
    end
  end

  def main
    part1
    part2
  end
end

DayX.main if __FILE__ == $PROGRAM_NAME
