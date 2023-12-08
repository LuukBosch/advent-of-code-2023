def transform_range(seed_range, maps)
  to_be_mapped = [seed_range]
  final_mapped = []
  maps.each do |map, offset|
    new_to_be_mapped = []
    to_be_mapped.each do |range|
      not_mapped, mapped = *map_range(range, map, offset)
      new_to_be_mapped.concat(not_mapped)
      final_mapped.concat(mapped)
    end
    to_be_mapped = new_to_be_mapped
  end
  final_mapped.concat(to_be_mapped)
  final_mapped
end

def map_range(seed_range, map_range, offset)
  if seed_range.first > map_range.last || seed_range.last < map_range.first
    [[seed_range], []]
  elsif map_range.include?(seed_range.begin) && !map_range.include?(seed_range.end)
    [[((map_range.end + 1)..seed_range.end)], [(seed_range.begin + offset)..(map_range.end + offset)]]
  elsif map_range.include?(seed_range.begin) && map_range.include?(seed_range.end)
    [[],  [(seed_range.begin + offset..seed_range.end + offset)]]
  elsif !map_range.include?(seed_range.begin) && map_range.include?(seed_range.end)
    [[(seed_range.begin..map_range.begin - 1), ],[(map_range.begin+offset..seed_range.end + offset)]]
  else
    [
      [(seed_range.begin..map_range.begin - 1),(map_range.end + 1..seed_range.end)],
      [(map_range.begin + offset..map_range.end + offset)]
    ]
  end
end

input = File.readlines('example.txt', chomp: true)

seeds = []
input.shift(2).join("").scan(/\d+/).each_slice(2) do |test|
  seeds << (test[0].to_i..(test[0].to_i + test[1].to_i - 1).to_i)
end

almanac = []
input.each do |line|
  if line.include?("map")
    almanac << {}
  else
    unless line.empty?
      destination, source, step = *line.scan(/\d+/).map(&:to_i)
      almanac.last[source..(source + step - 1)] = destination - source
    end
  end
end

final_map = []
seeds.each do |seed_range|
  mapped_seeds = [seed_range]
  almanac.each do |maps|
    newly_transformed = []
    mapped_seeds.each do |seed_range_2|
      newly_transformed.concat(transform_range(seed_range_2, maps))
    end
    mapped_seeds = newly_transformed
  end
  final_map.concat(mapped_seeds)
end

pp final_map.map(&:begin).min