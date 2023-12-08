input = File.readlines('input.txt', chomp: true)
time = input.first.scan(/\d+/).join("").to_i
record_distance = input.last.scan(/\d+/).join("").to_i
possibilities = []
(0..time).each do |second_held|
  distance = second_held * (time - second_held)
  possibilities << distance if (distance >record_distance)
end
pp possibilities.size