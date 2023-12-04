sum = 0
File.readlines('input.txt', chomp: true).each do |line|
  winning_number, my_numbers = line.split(":")[1]..split("|").map{_1.scan(/\d+/)}
  points = my_numbers.select{winning_number.include?(_1)}
  next if points.empty?

  points.size == 1 ? sum += 1 : sum += 2**(points.size - 1)
end
pp sum