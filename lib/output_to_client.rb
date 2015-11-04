require_relative 'executable.rb'

class OutputToClient

  attr_accessor :client

  def initialize(client = :no_client)
    @client = client
  end

  def write_request_to_browser(from_machine)
    if from_machine.nil?
      ["some stuff"]
    else
      response = "<pre>" + from_machine.join("\n") + "</pre>"
    end
    output = "<html><head></head><body>#{response}</body></html>"
    headers = ["http/1.1 200 ok",
              "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
              "server: ruby",
              "content-type: text/html; charset=iso-8859-1",
              "content-length: #{output.length}\r\n\r\n"].join("\r\n")
    client.puts headers
    client.puts output
  end

end
