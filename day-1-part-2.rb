file = File.open("input/day-1.txt", "r")

@numbers_in_words = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]

@words_to_numbers = {
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

file.each_line do |line|
  indexes = []

  @numbers_in_words.each do |word|
    next unless line.include?(word)
    start_index = 0

    while start_index < line.length
      index = line.index(word, start_index)
      break unless index
      indexes << {value: @words_to_numbers[word], index: index}
      start_index = index + 1
    end
  end

  line.chars.each_with_index do |char, index|
    if char.match?(/\d/)
      indexes << {value: char, index: index}
    end
  end

  indexes.sort_by! { |hash| hash[:index] }

  calibration_value = if indexes.length == 0
    0
  else
    indexes[0][:value] + indexes[-1][:value]
  end

  sum += calibration_value.to_i
end

puts sum

file.close
