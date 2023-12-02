sum = 0
File.readlines('input.txt', chomp: true).each do |line|
  mins = [0,0,0]
  sets = line.split(":")[1]

  sets.split(";").each do |set|
    red = set.scan(/(\d+)\s+red/).flatten.first.to_i
    green = set.scan(/(\d+)\s+green/).flatten.first.to_i
    blue = set.scan(/(\d+)\s+blue/).flatten.first.to_i
    mins = [mins, [red, green, blue]].transpose.map &:max
  end
  sum += mins.inject(:*)
end
pp sum