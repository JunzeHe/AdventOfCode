module Day20
  module_function

  def parse(raw_input)
    raw_input.split("\n\n").each_with_object({}) do |tile_str, tiles|
      lines = tile_str.split("\n")
      tile = lines[1..]
      tile_id = lines.first.match(/Tile (?<tile_id>\d+):/)['tile_id'].to_i
      tiles[tile_id] = tile
    end
  end

  def find_edges(input)
    lines = input.split("\n")
    edges = []
    edges << lines.first
    edges << lines.last

    left_edge = ''
    right_edge = ''
    lines.each do |line|
      left_edge += line[0]
      right_edge += line[-1]
    end

    edges << left_edge
    edges << right_edge

    # Match against the tile being flipped
    edges.dup.each do |edge|
      edges << edge.reverse
    end

    edges
  end

  def multiply_corner_ids(input)
    tiles = parse(input)
    tile_edges = tiles.transform_values do |tile|
      find_edges(tile.join("\n"))
    end
    matches = {}

    tile_edges.each do |tile_id, edges|
      bordering_tiles = tile_edges.values.select do |other_edges|
        (other_edges & edges).length.positive? && other_edges != edges
      end

      matches[tile_id] = bordering_tiles.count
    end

    corners = matches.select do |_tile_id, match_count|
      match_count == 2
    end

    corners.keys.reduce(&:*)
  end

  def part1
    File.open('./app/day20_input') do |f|
      puts "Part 1 #{multiply_corner_ids(f.read)}"
    end
  end

  def part2
    File.open('./app/day20_input') do |f|
      # puts f.read
    end
  end

  def main
    part1
    part2
  end
end

Day20.main if __FILE__ == $PROGRAM_NAME
