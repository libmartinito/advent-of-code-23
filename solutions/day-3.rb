part = ARGV[0]
# filepath = "input/day-3.txt"
filepath = "test/day-3-part-1.txt"
# filepath = "test/day-3-part-2.txt"
file = File.open(filepath, "r")
@lines = file.read.split("\n")

def get_current_line_part_numbers(line_checked, line, coordinate)
  current_line_part_numbers = []
  range_start = get_range_start(coordinate)
  range_end = get_range_end(coordinate, line)

  line_checked[range_start..range_end].chars.each do |char|
    if is_symbol?(char)
      current_line_part_numbers << line[coordinate[:start]..coordinate[:end]].to_i
    end
  end

  line[range_start..range_end].chars.each do |char|
    if is_symbol?(char)
      current_line_part_numbers << line[coordinate[:start]..coordinate[:end]].to_i
    end
  end

  current_line_part_numbers
end

def get_range_start(coordinate)
  if coordinate[:start] == 0
    coordinate[:start]
  else
    coordinate[:start] - 1
  end
end

def get_range_end(coordinate, line)
  if coordinate[:end] == line.length - 1
    coordinate[:end]
  else
    coordinate[:end] + 1
  end
end

def is_symbol?(char)
  !!char.match?(/[^\w\s.]/)
end

def parse_line_with_numbers
  line_number_positions = []

  @lines.each_with_index do |line, line_index|
    line_number_position = {}

    line.chars.each_with_index do |char, char_index|
      if char.match?(/\d/)
        if line[char_index - 1] && !line[char_index - 1].match?(/\d/) || char_index == 0
          line_number_position[:start] = char_index
        end

        if line[char_index + 1] && !line[char_index + 1].match?(/\d/) || char_index == line.length - 1
          line_number_position[:end] = char_index
        end
      end

      if line_number_position[:start] && line_number_position[:end]
        line_number_position[:line] = line_index
        line_number_positions << line_number_position
        line_number_position = {}
      end
    end
  end

  line_number_positions
end

def solve_part_one
  line_number_positions = parse_line_with_numbers
  part_numbers = []

  @lines.each_with_index do |line, line_index|
    filtered_coordinates = line_number_positions
      .select { |line_number_position| line_number_position[:line] == line_index }
      .map { |hash| {start: hash[:start], end: hash[:end]} }

    next if filtered_coordinates.empty?

    if line_index == 0
      line_after = @lines[line_index + 1]

      filtered_coordinates.each do |coordinate|
        part_numbers.concat(get_current_line_part_numbers(line_after, line, coordinate))
      end
    elsif line_index == @lines.length - 1
      line_before = @lines[line_index - 1]

      filtered_coordinates.each do |coordinate|
        part_numbers.concat(get_current_line_part_numbers(line_before, line, coordinate))
      end
    else
      line_after = @lines[line_index + 1]
      line_before = @lines[line_index - 1]

      filtered_coordinates.each do |coordinate|
        against_line_after_part_numbers = get_current_line_part_numbers(line_after, line, coordinate)
        against_line_before_part_numbers = get_current_line_part_numbers(line_before, line, coordinate)

        part_numbers.concat((against_line_after_part_numbers + against_line_before_part_numbers).uniq)
      end
    end
  end

  puts "part numbers sum: #{part_numbers.sum}"
end

def solve_part_two
end

case part
when "1"
  solve_part_one
when "2"
  solve_part_two
else
  raise "Invalid part!"
end
