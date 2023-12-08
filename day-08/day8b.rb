def steps_to_z(position, route_map, instructions)
  steps = 0

  instructions.cycle do |instruction|
    steps += 1
    position = route_map[position][instruction]
    break if position.end_with?("Z")
  end

  steps
end

input = File.readlines('input.txt', chomp: true)
instructions = input.shift(2)[0].split('')
route_map = input.map do |line|
  start, left_right = line.split("=")
  left, right = left_right.gsub(/[()\s]/, "").split(",")
  [start.strip, {"L" => left, "R" => right}]
end.to_h

pp route_map.keys.grep(/A\z/).map{steps_to_z(_1, route_map, instructions)}.reduce(1, :lcm)
