sum = 0
File.readlines('example.txt', chomp: true).each do |line|
  numbers = line.scan(/\d/)
  sum += (numbers.first.to_s + numbers.last.to_s).to_i
end
pp sum