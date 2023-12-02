require "dotenv"
require "net/http"
require "uri"

Dotenv.load(".env")

day_number = ARGV[0]
url = "https://adventofcode.com/2023/day/#{day_number}/input"

def download_input(url, filename)
  uri = URI.parse(url)

  Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
    request = Net::HTTP::Get.new(url)
    request["Cookie"] = "session=#{ENV["SESSION_COOKIE"]}"
    response = http.request(request)

    File.write(filename, response.body)
  end
end

download_input(url, "input/day-#{day_number}.txt")
