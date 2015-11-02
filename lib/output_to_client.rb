
class OutputToClient

  attr_reader :from_machine

  def initialize(from_machine = [], client = :no_client)
    @from_machine = from_machine
    @client = client
  end

  # puts "Got this request:"
  # puts request_lines.inspect
  #
  # puts "Sending response."
  # response = "<pre>" + request_lines.join("\n") + "\n\nTHIS IS A TEST!!!!!!!!!!!" + "</pre>"
  # output = "<html><head></head><body>#{response}</body></html>"
  # headers = ["http/1.1 200 ok",
  #           "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
  #           "server: ruby",
  #           "content-type: text/html; charset=iso-8859-1",
  #           "content-length: #{output.length}\r\n\r\n"].join("\r\n")
  # client.puts headers
  # client.puts output


end
