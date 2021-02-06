module Day5
  module_function

  NUM_ROWS = 128
  NUM_COLS = 8
  def seat_row(row_desc)
    rows = (0..NUM_ROWS - 1).to_a

    row_desc.split('').each do |letter|
      midpoint = (rows.length / 2.0) - 1
      case letter
      when 'F'
        rows = rows[0..midpoint]
      when 'B'
        rows = rows[midpoint + 1..]
      end
    end

    rows.first
  end

  def seat_column(column_desc)
    columns = (0..NUM_COLS - 1).to_a

    column_desc.split('').each do |letter|
      midpoint = (columns.length / 2.0) - 1
      case letter
      when 'L'
        columns = columns[0..midpoint]
      when 'R'
        columns = columns[midpoint + 1..]
      end
    end

    columns.first
  end

  def seat_id(seat_location)
    row_desc = seat_location[0..7]
    column_desc = seat_location[7..]

    (seat_row(row_desc) * 8) + seat_column(column_desc)
  end

  def part1
    ids = []
    File.open('./app/day5_input').each_line do |line|
      ids <<  seat_id(line)
    end

    puts "Part1 Max: #{ids.max}"
  end

  def part2
    ids = []
    File.open('./app/day5_input').each_line do |line|
      ids <<  seat_id(line)
    end
    ids = ids.sort

    my_seat_id = nil
    ids.each_with_index do |id, index|
      next if index.zero? || index == ids.length - 1

      next_id = ids[index + 1]
      my_seat_id = id + 1 if next_id != (id + 1)
    end

    puts "Part2 #{my_seat_id}"
  end

  def main
    part1
    part2
  end
end

Day5.main if __FILE__ == $PROGRAM_NAME
