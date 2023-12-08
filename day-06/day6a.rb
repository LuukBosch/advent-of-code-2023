input = File.readlines('input.txt', chomp: true)
times = input.first.scan(/\d+/).map(&:to_i)
record_distances = input.last.scan(/\d+/).map(&:to_i)
total = []
times.zip(record_distances).each do |time, record_distance|
  possibilities = []
  (0..time).each do |second_held|
    distance = second_held * (time - second_held)
    possibilities << distance if (distance > record_distance)
  end
  total << possibilities.size
end
pp total.inject(:*)