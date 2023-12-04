def gear_for_element(square, x, y)
  directions = [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]]
  y_max = square.size
  x_max = square.first.size
  chains = []

  directions.each do |dy, dx|
    new_y, new_x = y + dy, x + dx
    if new_y.between?(0, y_max - 1) && new_x.between?(0, x_max - 1) && square[new_y][new_x] == "*"
      chains << [new_y, new_x]
    end
  end

  chains
end

square = []
chains = Hash.new { |h, k| h[k] = [] }
File.readlines('input.txt', chomp: true).each do |line|
  square << line.split("")
end

square.each_with_index do |row, y|
  number = ""
  gears_for_number = []
  row.each_with_index do |element, x|
    if element.match(/^(\d)$/)
      number += element
      gear_for_element(square, x, y).each do |gear|
        gears_for_number << gear
      end
    else
      gears_for_number.uniq.each do |chain|
        chains[chain] << number.to_i if !number.empty?
      end
      number = ""
      gears_for_number = []
    end
  end
  gears_for_number.uniq.each do |chain|
    chains[chain] << number.to_i unless number.empty?
  end
end
pp chains.select{|_, value| value.size == 2}.values.map{_1.inject(:*)}.inject(:+)

