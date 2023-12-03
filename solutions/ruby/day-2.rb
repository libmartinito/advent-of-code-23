part = ARGV[0]

filepath = "input/day-2.txt"
# filepath = "test/day-2-part-1.txt"
file = File.open(filepath, "r")
@lines = file.read.split("\n")

def solve_part_one
  color_count = {
    red: 12,
    green: 13,
    blue: 14
  }

  possible_game_ids = []

  @lines.each do |line|
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
end

def solve_part_two
  game_powers = []

  @lines.each do |line|
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

  puts "Sum: #{game_powers.sum}"
end

case part
when "1"
  solve_part_one
when "2"
  solve_part_two
else
  raise "Invalid part!"
end
