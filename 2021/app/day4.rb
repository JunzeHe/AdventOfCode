module Day4
  module_function

  def parse(raw_input)
    parsed_input = []
    while !raw_input.empty? && (next_split = raw_input.index('') || raw_input.length - 1)
      parsed_input << raw_input.slice!(0..next_split).join(' ').chomp.split(' ').each_with_object({}) do |line, agg|
        key, value = line.split(':')

        agg[key] = value
      end
    end

    parsed_input
  end

  REQUIRED_KEYS = %w[hcl iyr eyr ecl pid byr hgt].freeze
  def valid_passport?(passport_hash)
    passport_hash.keys.intersection(REQUIRED_KEYS).sort == REQUIRED_KEYS.sort
  end

  def part1
    passports = nil
    File.open('./app/day4_input') do |f|
      raw_input = f.readlines.map(&:chomp)
      passports = parse(raw_input)
    end
    puts "Part1 #{passports.count { |p| valid_passport?(p) }}"
  end

  def in_between?(min, max, val)
    val.to_i >= min && val.to_i <= max
  end

  def more_valid_passport?(passport)
    # I recognize that this boolean is incomprehensible. If this was a more
    # long standing program, I would have given the booleans variable names
    valid_passport?(passport) &&
      in_between?(1920, 2002, passport['byr']) &&
      in_between?(2010, 2020, passport['iyr']) &&
      in_between?(2020, 2030, passport['eyr']) &&
      ((passport['hgt'].include?('cm') && in_between?(150, 193, passport['hgt'])) ||
        (passport['hgt'].include?('in') && in_between?(59, 76, passport['hgt']))) &&
      passport['hcl'].match?(/\A#[0-9a-f]{6}\z/) &&
      %w[amb blu brn gry grn hzl oth].include?(passport['ecl']) &&
      passport['pid'].match?(/\A[0-9]{9}\z/)
  end

  def part2
    passports = nil
    File.open('./app/day4_input') do |f|
      raw_input = f.readlines.map(&:chomp)
      passports = parse(raw_input)
    end
    puts "Part2 #{passports.count { |p| more_valid_passport?(p) }}"
  end

  def main
    part1
    part2
  end
end

Day4.main if __FILE__ == $PROGRAM_NAME
