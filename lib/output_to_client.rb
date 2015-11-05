require_relative 'executable.rb'

class OutputToClient

  attr_accessor :client

  def initialize(client = :no_client)
    @client = client
  end

  def write_request_to_browser(from_machine,status_code)
    puts "write_request_to_browser occurring"
    if from_machine.nil?
      ["some stuff"]
    else
      response = "<pre>" + from_machine.join("\n") + "</pre>"
    end
    output = "<html><head></head><body>#{response}</body></html>"
    if status_code == 303
      headers = ["http/1.1 302 found\r\nlocation: http://127.0.0.1:9292/game\r\n\r\n"].join("\r\n")
    else
      headers = ["http/1.1 200 ok",
              "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
              "server: ruby",
              "content-type: text/html; charset=iso-8859-1",
              "content-length: #{output.length}\r\n\r\n"].join("\r\n")
    end
    client.puts headers
    client.puts output
  end
end
 #
 #   "<html><head></head><body><pre>#{respond(object)}</pre></body></html>"
 #
 # end
 #
 # def headers
 #   if respond(object)[0..3] == "Good"
 #     ["HTTP/1.1 303 Temporary Redirect",
 #     "Location: http://127.0.0.1:9292/game\r\n\r\n"].join("\r\n")
 #   else
 #   ["http/1.1 200 ok",
 #     "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
 #     "server: ruby",
 #     "content-type: text/html; charset=iso-8859-1",
 #     "content-length: #{output.length}\r\n\r\n"].join("\r\n")
 #   end
 # end
