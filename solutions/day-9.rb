part = ARGV[0]
filepath = "input/day-9.txt"
# filepath = "test/day-9-part-1.txt"
# filepath = "test/day-9-part-2.txt"
file = File.open(filepath, "r")
@lines = file.read.split("\n")

def get_differences(report_values)
  differences = []

  report_values.each_with_index do |value, index|
    next if index == 0
    differences << value - report_values[index - 1]
  end

  puts "differences: #{differences}"
  differences
end

def solve_part_one
  last_values = []

  @lines.each do |line|
    report_values = line.split(" ").map(&:to_i)
    extrapolation_info = [report_values]

    until report_values.all? { |value| value == 0 }
      report_values = get_differences(report_values)
      extrapolation_info << report_values
    end

    last_value = 0

    extrapolation_info.each do |info|
      last_value += info.last
    end

    last_values << last_value
  end

  puts "Last value sum: #{last_values.sum}"
end

def solve_part_two
  last_values = []

  @lines.each do |line|
    report_values = line.split(" ").map(&:to_i)
    extrapolation_info = [report_values]

    until report_values.all? { |value| value == 0 }
      report_values = get_differences(report_values)
      extrapolation_info << report_values
    end

    puts "extrapolation_info: #{extrapolation_info.reverse}"

    current_value = 0
    extrapolation_info.reverse.each_with_index do |info, index|
      next if index == 0

      puts "info: #{info}"
      current_value = info.first - current_value
      puts "current_value: #{current_value}"
    end

    last_values << current_value
  end

  puts "last_values: #{last_values}"
  puts "Last value sum: #{last_values.sum}"
end

case part
when "1"
  solve_part_one
when "2"
  solve_part_two
else
  raise "Invalid part!"
end
