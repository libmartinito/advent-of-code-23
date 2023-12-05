number = ARGV[0]

unless number&.match?(/\d/)
  puts "Please provide a number"
  exit 1
end

solution_file_contents = <<~RUBY
  part=ARGV[0]
  # filepath = "input/day-#{number}.txt"
  filepath = "test/day-#{number}-part-1.txt"
  # filepath = "test/day-#{number}-part-2.txt"
  file = File.open(filepath, "r")
  @lines = file.read.split("\\n")

  def solve_part_one
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
RUBY

Dir.mkdir("solutions") unless Dir.exist?("solutions")
Dir.mkdir("test") unless Dir.exist?("test")
File.write("solutions/day-#{number}.rb", solution_file_contents)
File.write("test/day-#{number}-part-1.txt", "")
File.write("test/day-#{number}-part-2.txt", "")

puts "Created files for day #{number}!"
