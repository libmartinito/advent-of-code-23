part = ARGV[0]
filepath = "input/day-8.txt"
# filepath = "test/day-8-part-1.txt"
# filepath = "test/day-8-part-2.txt"
file = File.open(filepath, "r")
@lines = file.read.split("\n\n")

def get_network_map
  network_map = {}

  @lines.last.split("\n").each do |node|
    network_map[node.split(" = ").first] = {
      L: node.split(" = ").last.delete("(").delete(")").split(", ")[0],
      R: node.split(" = ").last.delete("(").delete(")").split(", ")[1]
    }
  end

  network_map
end

def get_ghost_current_values
  ghost_current_values = []

  @lines.last.split("\n").each do |node|
    node_key = node.split(" = ").first

    if node_key[-1] == "A"
      ghost_current_values << node_key
    end
  end

  ghost_current_values
end

def solve_part_one
  instructions = @lines.first
  network_map = get_network_map

  current_value = "AAA"
  current_index = 0
  count = 0

  while current_value != "ZZZ"
    current_value = network_map[current_value][instructions[current_index].to_sym]
    current_index = (current_index + 1 == instructions.length) ? 0 : current_index + 1
    count += 1
  end

  puts "Count: #{count}"
end

def solve_part_two
  instructions = @lines.first
  network_map = get_network_map
  ghost_current_values = get_ghost_current_values

  ghost_current_values.each_with_index do |ghost_current_value, index|
    current_value = ghost_current_value
    current_index = 0
    count = 0

    until current_value.end_with?("Z")
      current_value = network_map[current_value][instructions[current_index].to_sym]
      current_index = (current_index + 1 == instructions.length) ? 0 : current_index + 1
      count += 1
    end

    ghost_current_values[index] = {current_value:, count:}
  end

  count = ghost_current_values.map { |ghost_current_value| ghost_current_value[:count] }.reduce(:lcm)
  puts "Count: #{count}"
end

case part
when "1"
  solve_part_one
when "2"
  solve_part_two
else
  raise "Invalid part!"
end
