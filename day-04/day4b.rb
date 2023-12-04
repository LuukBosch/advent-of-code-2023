set = Hash.new(0)
File.readlines('input.txt', chomp: true).each_with_index do |line, index|
  set[index] += 1
  winning_number, my_numbers = line.split(":")[1].split("|").map{_1.scan(/\d+/)}
  1.upto((winning_number & my_numbers).size){set[index + _1] += (1 * set[index])}
end
pp set.values.inject(:+)


