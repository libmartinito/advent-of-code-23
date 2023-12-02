raw_file = File.open("input/day-2.txt", "r")
file_lines = raw_file.read.split("\n")

game_powers = []

file_lines.each do |line|
  _game, data = line.split(": ")
  handfuls = data.split(";")

  minimum_blocks_for_game = {
    red: 0,
    green: 0,
    blue: 0
  }

  handfuls.each do |handful|
    cubes = handful.split(",")

    cubes.each do |cube|
      cube_count, cube_color = cube.split(" ")

      if cube_count.to_i > minimum_blocks_for_game[cube_color.to_sym]
        minimum_blocks_for_game[cube_color.to_sym] = cube_count.to_i
      end
    end
  end

  game_power = minimum_blocks_for_game.values.inject(:*)
  game_powers << game_power
end

sum = game_powers.sum
puts "Sum: #{sum}"
