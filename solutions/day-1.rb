part = ARGV[0]

filepath = "input/day-1.txt"
# filepath = "test/day-1-part-2.txt"
file = File.open(filepath, "r")
@lines = file.read.split("\n")

def solve_part_one
  first_value = ""
  last_value = ""
  sum = 0

  @lines.each do |line|
    line.chars.each do |char|
      if char.match?(/\d/)
        first_value = char
        break
      end
    end

    line.chars.reverse_each do |char|
      if char.match?(/\d/)
        last_value = char
        break
      end
    end

    calibration_value = first_value + last_value
    sum += calibration_value.to_i
  end

  puts "Sum: #{sum}"
end

def solve_part_two
  numbers_in_words = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]

  words_to_numbers = {
    "one" => "1",
    "two" => "2",
    "three" => "3",
    "four" => "4",
    "five" => "5",
    "six" => "6",
    "seven" => "7",
    "eight" => "8",
    "nine" => "9"
  }

  sum = 0

  @lines.each do |line|
    indexes = []

    numbers_in_words.each do |word|
      next unless line.include?(word)
      start_index = 0

      while start_index < line.length
        index = line.index(word, start_index)
        break unless index

        indexes << {value: words_to_numbers[word], index: index}
        start_index = index + 1
      end
    end

    line.chars.each_with_index do |char, index|
      if char.match?(/\d/)
        indexes << {value: char, index: index}
      end
    end

    indexes.sort_by! { |hash| hash[:index] }

    calibration_value = indexes.first[:value] + indexes.last[:value]
    sum += calibration_value.to_i
  end

  puts "Sum: #{sum}"
end

case part
when "one"
  solve_part_one
when "two"
  solve_part_two
else
  raise "Invalid part!"
end
