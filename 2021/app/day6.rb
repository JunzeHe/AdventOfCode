module Day6
  module_function

  def yeses_per_group(group_answers)
    yeses = []
    group_answers.map { |a| a.split('') }.each { |a| yeses = yeses.union(a) }

    yeses.count
  end

  def total_yeses(all_answers)
    all_answers.map do |answer|
      Day6.yeses_per_group(answer)
    end.sum
  end

  def part1
    sum = nil
    File.open('./app/day6_input') do |f|
      input = f.read.chomp.split("\n\n").map { |a| a.split("\n") }
      sum = Day6.total_yeses(input)
    end

    puts "Part1 #{sum}"
  end

  def questions_with_all_yeses(group_answers)
    split_answers = group_answers.map { |a| a.split('') }
    yeses = split_answers.first || []
    split_answers.each { |a| yeses = yeses.intersection(a) }

    yeses.count
  end

  def total_yeses_with_all_yeses(all_answers)
    all_answers.map do |answer|
      Day6.questions_with_all_yeses(answer)
    end.sum
  end

  def part2
    sum = nil
    File.open('./app/day6_input') do |f|
      input = f.read.chomp.split("\n\n").map { |a| a.split("\n") }
      sum = Day6.total_yeses_with_all_yeses(input)
    end

    puts "Part2 #{sum}"
  end

  def main
    part1
    part2
  end
end

Day6.main if __FILE__ == $PROGRAM_NAME
