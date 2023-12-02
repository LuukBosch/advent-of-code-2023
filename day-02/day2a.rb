sum = 0
limits = {"red" => 12, "green" => 13, "blue" => 14}
File.readlines('input.txt', chomp: true).each do |line|
  possible = true
  game, sets = line.split(":")

  sets.split(";").each do |set|
    red = set.scan(/(\d+)\s+red/).flatten.first.to_i <= limits["red"]
    green = set.scan(/(\d+)\s+green/).flatten.first.to_i <= limits["green"]
    blue = set.scan(/(\d+)\s+blue/).flatten.first.to_i <= limits["blue"]
    unless red && green && blue
      possible = false
      break
    end
  end
  sum += game.scan(/\d+/).first.to_i if possible
end
pp sum