part = ARGV[0]
filepath = "input/day-6.txt"
# filepath = "test/day-6-part-1.txt"
# filepath = "test/day-6-part-2.txt"
file = File.open(filepath, "r")
@lines = file.read.split("\n")

def get_ways_to_win(time, distance_to_beat)
  ways_to_win = 0

  time.times do |i|
    distance = i * (time - i)

    if distance > distance_to_beat
      ways_to_win += 1
    end
  end

  ways_to_win
end

def solve_part_one
  times = @lines.first.split(":").last.split(" ")
  distances = @lines.last.split(":").last.split(" ")
  margins = []

  times.each_with_index do |time, index|
    ways_to_win = get_ways_to_win(time.to_i, distances[index].to_i)
    margins << ways_to_win
  end

  puts "Margin: #{margins.inject(:*)}"
end

def solve_part_two
  time = @lines.first.split(":").last.split(" ").join
  distance = @lines.last.split(":").last.split(" ").join

  ways_to_win = get_ways_to_win(time.to_i, distance.to_i)
  puts "Ways to win: #{ways_to_win}"
end

case part
when "1"
  solve_part_one
when "2"
  solve_part_two
else
  raise "Invalid part!"
end
