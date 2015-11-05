
class OutputToClient

  attr_accessor :client

  def initialize(client = :no_client)
    @client = client
  end

  def write_request_to_browser(from_machine,status_code)
    puts "write_request_to_browser occurring"
    response = "<pre>" + from_machine.join("\n") + "</pre>"
    output = "<html><head></head><body>#{response}</body></html>"
    if status_code == 302
      puts "redirect sent"
      headers = ["HTTP/1.1 302 Found",
              "Location: http://127.0.0.1:9292/game\r\n\r\n"].join("\r\n")
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
