require 'socket'
require 'json'

server = TCPServer.open(2000)
loop do
  Thread.start(server.accept) do |client|
    request = client.read_nonblock(256)
    STDERR.puts request
    
    request_header, request_body = request.split("\r\n\r\n", 2)
    request_header = request_header.split(" ")
    type = request_header[0]
    path = request_header[1]
    if File.exist? path
      response_body = File.read(path)
      client.puts "HTTP/1.0 200 OK\r\nContent-Type:text/html\r\n\r\n"
      case type.upcase
        when "GET"
          client.print(response_body)
        when "POST"
          params = JSON.parse(request_body)
          user_data = "<li>name: #{params['viking']['name']}</li><li>email: #{params['viking']['email']}</li>"
          client.print(response_body.gsub("<%= yield %>", user_data))
      end
    else
      client.print("HTTP/1.0 404 Resource Not Found\r\n\r\n")
    end
    client.close
  end
end
