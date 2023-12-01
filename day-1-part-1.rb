file = File.open("input/day-1.txt", "r")

sum = 0

file.each_line do |line|
  first_value = ""
  last_value = ""

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

  calibration_value = if first_value == ""
    0
  else
    first_value + last_value
  end

  sum += calibration_value.to_i
end

puts sum

file.close
