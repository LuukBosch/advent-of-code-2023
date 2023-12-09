ranges = File.readlines('input.txt', chomp: true).map{_1.split.map(&:to_i)}
result = ranges.sum do |range|
  diff_ranges = []
  diff_range = range
  while diff_range.any?(&:nonzero?)
    diff_ranges << diff_range
    diff_range = diff_range.each_cons(2).map { |first, second| second - first }
  end
  diff_ranges.sum { |dif_range| dif_range.last }
end
pp result
