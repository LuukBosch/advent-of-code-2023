input = File.readlines('input.txt', chomp: true)
seeds = input.shift(2).join("").scan(/\d+/).map(&:to_i)
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

mapped_seeds = []
seeds.each do |seed|
  mapped_seed = seed
  almanac.each do |maps|
    maps.each do |key, value|
      if key.include?(mapped_seed)
        mapped_seed = mapped_seed + value
        break
      end
    end
  end
  mapped_seeds << mapped_seed
end
pp mapped_seeds.min