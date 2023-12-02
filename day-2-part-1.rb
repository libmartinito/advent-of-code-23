raw_file = File.open("input/day-2.txt", "r")
file_lines = raw_file.read.split("\n")

color_count = {
  red: ARGV[0].to_i,
  green: ARGV[1].to_i,
  blue: ARGV[2].to_i
}

possible_game_ids = []

file_lines.each do |line|
  game, data = line.split(": ")
  handfuls = data.split(";")

  is_possible = true

  handfuls.each do |handful|
    cubes = handful.split(",")

    cubes.each do |cube|
      cube_count, cube_color = cube.split(" ")

      if cube_count.to_i > color_count[cube_color.to_sym]
        is_possible = false
      end
    end
  end

  if is_possible
    possible_game_ids << game.split(" ").last.to_i
  end
end

puts "Sum: #{possible_game_ids.sum}"
