require 'socket'
require 'pry'
tcp_server = TCPServer.new(9292)
client = tcp_server.accept
quitter = ""
counter = 0

until quitter.chomp == 'quit' do
  counter +=1
  puts "Ready for a request"
  request_lines = []
  while line = client.gets and !line.chomp.empty?
    request_lines << line.chomp
  end

  puts "Got this request:"
  puts request_lines.inspect

  puts "Sending response."
  response = "<pre>" + request_lines.join("\n") + "\n\n COUNT :#{counter}" + "</pre>"



  output = "<html><head></head><body>#{response}</body></html>"
  headers = ["http/1.1 200 ok",
            "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
            "server: ruby",
            "content-type: text/html; charset=iso-8859-1",
            "content-length: #{output.length}\r\n\r\n"].join("\r\n")
  client.puts headers
  client.puts output

  puts ["Wrote this response:", headers, output].join("\n")
  # client.close
  puts "\nResponse complete, go again? (if not, type 'quit')"
  quitter = gets
end
