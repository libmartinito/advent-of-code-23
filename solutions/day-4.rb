part = ARGV[0]
filepath = "input/day-4.txt"
# filepath = "test/day-4-part-1.txt"
# filepath = "test/day-4-part-2.txt"
file = File.open(filepath, "r")
@lines = file.read.split("\n")

def solve_part_one
  points = []

  @lines.each do |line|
    _, numbers = line.split(": ")
    winning_numbers_str, numbers_you_have_str = numbers.split(" | ")
    winning_numbers = winning_numbers_str.split(" ").map(&:to_i)
    numbers_you_have = numbers_you_have_str.split(" ").map(&:to_i)
    points_for_line = 0

    numbers_you_have.each do |number|
      next if !winning_numbers.include?(number)

      if points_for_line == 0
        points_for_line = 1
      else
        points_for_line *= 2
      end
    end

    points << points_for_line
  end

  puts "Total points: #{points.sum}"
end

def solve_part_two
  scratchcards = {}

  @lines.each_with_index do |line, index|
    if scratchcards[index].nil?
      scratchcards[index] = 1
    else
      scratchcards[index] += 1
    end

    _card, numbers = line.split(": ")
    winning_numbers_str, numbers_you_have_str = numbers.split(" | ")
    winning_numbers = winning_numbers_str.split(" ").map(&:to_i)
    numbers_you_have = numbers_you_have_str.split(" ").map(&:to_i)
    winning_numbers_you_have = winning_numbers & numbers_you_have

    next if winning_numbers_you_have.count == 0
    starting_index = index + 1

    winning_numbers_you_have.count.times do
      next if starting_index > @lines.count - 1

      if scratchcards[starting_index].nil?
        scratchcards[starting_index] = 1 * scratchcards[index]
      else
        scratchcards[starting_index] += 1 * scratchcards[index]
      end

      starting_index += 1
    end
  end

  puts "Scratchcards count: #{scratchcards.values.sum}"
end

case part
when "1"
  solve_part_one
when "2"
  solve_part_two
else
  raise "Invalid part!"
end
