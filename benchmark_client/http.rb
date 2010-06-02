require 'net/http'

def start_connection
  Net::HTTP.version_1_1
  http = Net::HTTP.new 'localhost', 3000
  http.start
  http
end

def end_connection http
  http.finish
end