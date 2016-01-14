#require 'open-uri'
#open ("http://www.tutorialspoint.com/index.htm") {|f| puts f.read}

require 'socket'
require 'json'

host = "localhost"
port = 2000
path = "webserver_and_browser/index.html"
params = {}

print "Type of request (GET/POST)?: "
req = gets.chomp.upcase

case req
  when 'GET'
    request = "GET #{path} HTTP/1.0\r\n\r\n"
  when 'POST'
    print "Enter your name: "
    name = gets.chomp
    print "Enter your email: "
    email = gets.chomp
    params = {'viking' => {'name' => name, 'email' => email}}.to_json
    request = "POST webserver_and_browser/thanks.html HTTP/1.0\nContent-Length: #{params.length}\r\n\r\n#{params}"
end


socket = TCPSocket.open(host, port)
socket.print(request)
response = socket.read
headers,body = response.split("\r\n\r\n", 2)
puts headers
puts "------------"
print body
