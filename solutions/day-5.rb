part = ARGV[0]
# filepath = "input/day-5.txt"
filepath = "test/day-5-part-1.txt"
# filepath = "test/day-5-part-2.txt"
file = File.open(filepath, "r")
@lines = file.read.split("\n\n")

def make_conversion_map
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

  conversion_map
end

def get_lowest_location(seeds)
  conversion_map = make_conversion_map
  locations = []

  seeds.each do |seed|
    current_destination = seed.to_i

    conversion_map.each do |_, ranges_info|
      ranges_info.each do |range_info|
        range_to_check = range_info[:start]..(range_info[:start] + range_info[:range] - 1)

        if range_to_check.include?(current_destination)
          current_destination = range_info[:destination] + (current_destination - range_info[:start])
          break
        end
      end
    end

    locations << current_destination
  end

  locations.min
end

# def get_lowest_location_in_range(seeds_ranges)
#   conversion_map = make_conversion_map
#   locations = []
#
#   seeds_ranges.each do |seed_range|
#     current_destination = 0
#
#     conversion_map.each do |map, ranges_info|
#       puts "Map: #{map}"
#       ranges_info.each do |range_info|
#         puts "range_info: #{range_info}"
#         overlapping_range = [seed_range[:start], range_info[:start]].max..[seed_range[:start] + seed_range[:range] - 1, range_info[:start] + range_info[:range] - 1].min
#         min_value = overlapping_range.begin if overlapping_range.begin < overlapping_range.end
#         puts "Min value: #{min_value}"
#         if min_value
#           current_destination = range_info[:destination] + (min_value - range_info[:start])
#           puts "Current destination: #{current_destination}"
#           break
#         end
#       end
#     end
#
#     locations << current_destination
#   end
#
#   puts "Locations: #{locations.min}"
# end

def solve_part_one
  seeds = @lines[0].split(": ").last.split(" ")
  min = get_lowest_location(seeds)
  puts "Minumum location: #{min}"
end

# def solve_part_two
#   seeds = @lines[0].split(": ").last.split(" ")
#   seeds_ranges = []
#
#   seeds.each_with_index do |seed, index|
#     seeds_ranges << {start: seed.to_i, range: seeds[index + 1].to_i} if index.even?
#   end
#
#   puts "Seed ranges: #{seeds_ranges}"
#   get_lowest_location_in_range(seeds_ranges)
# end

case part
when "1"
  solve_part_one
when "2"
  solve_part_two
else
  raise "Invalid part!"
end
