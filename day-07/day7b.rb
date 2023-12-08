def sorting_function(hand_a, hand_b)
  range = ["A", "K", "Q", "T", "9", "8", "7", "6", "5", "4", "3", "2", "J"]
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

def best_type_using_joker(hand)
  return hand.chars.tally.values.sort unless hand.include?("J")

  tally = hand.chars.tally.sort.to_h
  j_count = tally.delete("J")
  if  j_count == 5 || tally.values.max + j_count == 5
    [5]
  elsif tally.values.max + j_count == 4
    [1,4]
  elsif j_count == 1 && tally.values.count == 2
    [2,3]
  elsif tally.values.max + j_count == 3
    [1, 1, 3]
  else
    [1, 1, 1, 2]
  end
end

hand_bid_map = {}
File.readlines('input.txt', chomp: true).each do |line|
  hand, bid = line.split(" ")
  hand_bid_map[hand] = bid.to_i
end
hands = hand_bid_map.keys

mapped_by_type = hands.each_with_object(
  Hash.new { |h, k| h[k] = [] }
) { |hand, sorted_by_type| sorted_by_type[best_type_using_joker(hand)] << hand }


sorted_hands = [[1, 1, 1, 1, 1], [1, 1, 1, 2], [1, 2, 2], [1, 1, 3], [2, 3], [1, 4],[5]].map do |type|
  mapped_by_type[type].sort{sorting_function(_1, _2)}
end.flatten

pp score = sorted_hands.each_with_index.sum { |hand, rank| hand_bid_map[hand] * (rank + 1) }