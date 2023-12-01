sum = 0
dict = Hash.new { |_hash, key| key }.merge({ "one" => "1", "two" => "2", "three" => "3", "four" => "4", "five" => "5", "six" => "6", "seven" => "7", "eight" => "8", "nine" => "9" })
NUMBER_RE = Regexp.union(/\d/, Regexp.union(dict.keys))
INVERSE_NUMBER_RE = Regexp.union(/\d/, Regexp.union(dict.keys.map(&:reverse)))
File.readlines('input.txt', chomp: true).each do |line|
  first = line.match(NUMBER_RE).to_s
  last = line.reverse.match(INVERSE_NUMBER_RE).to_s.reverse
  sum += (dict[first] + dict[last]).to_i
end
pp sum