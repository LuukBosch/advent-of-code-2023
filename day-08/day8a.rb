input = File.readlines('input.txt', chomp: true)
instructions = input.shift(2)[0].split('')
route_map = input.map do |line|
  start, left_right = line.split("=")
  left, right = left_right.gsub(/[()\s]/, "").split(",")
  [start.strip, {"L" => left, "R" => right}]
end.to_h


destination_reached = false
position = 'AAA'
steps = 0
until destination_reached do
  instructions.each do |instruction|
    steps += 1
    position = route_map[position][instruction]
    destination_reached = position == 'ZZZ'
    break if destination_reached
  end
end
pp steps