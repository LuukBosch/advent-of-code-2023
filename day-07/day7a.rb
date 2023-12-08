def sorting_function(hand_a, hand_b)
  range = ["A", "K", "Q", "J", "T", "9", "8", "7", "6", "5", "4", "3", "2"]
  return 0 if hand_a.nil? || hand_b.nil? || hand_a == hand_b
  hand_a.split("").zip(hand_b.split("")).each do |a, b|
    next if a == b
    if range.index(a) < range.index(b)
      return 1
    else
      return -1
    end
  end
end

hand_bid_map = {}
File.readlines('example.txt', chomp: true).each do |line|
  hand, bid = line.split(" ")
  hand_bid_map[hand] = bid.to_i
end

hands = hand_bid_map.keys
sorted_by_type = Hash.new { |h, k| h[k] = [] }
hands.each do |hand|
  sorted_by_type[hand.split("").tally.values.sort] << hand
end

sorted_hands = []
[[1, 1, 1, 1, 1], [1, 1, 1, 2], [1, 2, 2], [1, 1, 3], [2, 3], [1, 4],[5]].each do |type|
  sorted_hands.concat(sorted_by_type[type].sort{sorting_function(_1, _2)})
end

score = 0
sorted_hands.each_with_index do |hand, rank|
  score += hand_bid_map[hand] * (rank + 1)
end

pp score