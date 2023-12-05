part = ARGV[0]
filepath = "input/day-5.txt"
# filepath = "test/day-5-part-1.txt"
# filepath = "test/day-5-part-2.txt"
file = File.open(filepath, "r")
@lines = file.read.split("\n\n")

def get_lowest_location(seeds)
  conversion_map = {}

  @lines.each do |line|
    next if line.include?("seeds")
    map = line.split("\n")
    start_to_destination_map = []

    map.each do |mapping|
      next if mapping.include?("map")
      destination, start, range = mapping.split(" ")
      start_to_destination_map << {start: start.to_i, destination: destination.to_i, range: range.to_i}
    end

    conversion_map[map.first.split(" ").first] = start_to_destination_map
  end

  maps = ["seed-to-soil", "soil-to-fertilizer", "fertilizer-to-water", "water-to-light", "light-to-temperature", "temperature-to-humidity", "humidity-to-location"]

  seed_locations = []

  seeds.each do |seed|
    current_destination = seed.to_i

    maps.each do |map|
      conversion_map[map].each do |mapping|
        start = mapping[:start]
        destination = mapping[:destination]
        range = mapping[:range]
        range_to_check = (start..start + range - 1)

        if range_to_check.include?(current_destination)
          current_destination = destination + (current_destination - start)
          break
        end
      end
    end

    seed_locations << current_destination
  end

  seed_locations.min
end

def solve_part_one
  seeds = @lines[0].split(": ").last.split(" ")
  min = get_lowest_location(seeds)
  puts "Minumum location: #{min}"
end

def solve_part_two
end

case part
when "1"
  solve_part_one
when "2"
  solve_part_two
else
  raise "Invalid part!"
end
