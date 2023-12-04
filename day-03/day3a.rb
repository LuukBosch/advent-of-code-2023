def has_symbol_neighbour?(square, x, y)
  directions = [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]]
  y_max = square.size
  x_max = square.first.size

  directions.any? do |dy, dx|
    new_y, new_x = y + dy, x + dx
    next unless new_y.between?(0, y_max - 1) && new_x.between?(0, x_max - 1)
    square[new_y][new_x].match?(/[*\-$%+&\/@=#]/)
  end
end

engine_parts = []
square = []
File.readlines('input.txt', chomp: true).each do |line|
  square << line.split("")
end
square.each_with_index do |row, y|
  number = ""
  engine_part = false
  row.each_with_index do |element, x|
    if element.match(/^(\d)$/)
      number += element
      if !engine_part
        engine_part = has_symbol_neighbour?(square, x, y)
      end
    else
      engine_parts << number.to_i if engine_part
      number = ""
      engine_part = false
    end
  end
  engine_parts << number.to_i if engine_part
end

pp engine_parts.inject(:+)